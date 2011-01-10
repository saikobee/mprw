#!/usr/bin/ruby

require "ostruct"
require "librmpd"
require "webrick"
include  WEBrick

require "./initservlets"

class MprwConf < OpenStruct
end

conf = MprwConf.new(
    :web_port => 1234,
    :web_root => Dir.pwd,
    :mpd_host => "localhost",
    :mpd_port => 6600
)

server = HTTPServer.new(
    :Port           => conf.web_port,
    :DocumentRoot   => conf.web_root
)

mpd = MPD.new(
    conf.mpd_host,
    conf.mpd_port
)

# Enables callbacks
mpd.connect true

servlets = InitServlets.new server, mpd
servlets.load

# Cleanly exit the program upon SIGINT and SIGTERM
%w[INT TERM].each do |signal|
    trap signal do
        server.shutdown
        mpd.disconnect
    end
end

server.start
