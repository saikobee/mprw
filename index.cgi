#!/usr/bin/ruby

require "cgi"

$cgi = cgi = CGI.new("html4")

cgi.out do
    cgi.html do
        cgi.p do
            "Hello world"
        end
    end
end
