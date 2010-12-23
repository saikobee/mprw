#!/usr/bin/ruby

require "webrick"
include  WEBrick

require "./initservlets"

server = HTTPServer.new(
    :Port           => 1234,
    :DocumentRoot   => Dir.pwd
)

servlets = InitServlets.new server
servlets.load

%w[INT TERM].each do |signal|
    trap signal do
        server.stop
    end
end

server.start
