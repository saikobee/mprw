#!/usr/bin/ruby

require "librmpd"
require "webrick"
include  WEBrick

require "./initservlets"

server = HTTPServer.new(
    :Port           => 1234,
    :DocumentRoot   => Dir.pwd
)

mpd = MPD.new "localhost", 6600

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
