#!/usr/bin/ruby

require "cgi"

require "./buttons.rb"
require "./util.rb"

$cgi = cgi = CGI.new("html4")

def head cgi=$cgi
    u = Util
    cgi.head do
        u.title("mprw - mpd web remote") +
        u.css("main.css") +
        u.css("themes/dark.css") +
        u.script("main.js") +
        u.android_fix +
        u.utf8
    end
end

def page cgi=$cgi
    cgi.out do
        cgi.html do
            head +
            cgi.body do
                yield
            end
        end
    end
end

def header cgi=$cgi
    cgi.div :class => "banner_border" do
        cgi.h1 :class => "banner" do
            "mprw &ndash; mpd web remote"
        end
    end
end

b = Buttons
items = [
    b::SEP,

    ButtonGroup[
        b::PLAY_PAUSE,
    ],

    b::SEP,

    ButtonGroup[
        b::VOL_UP,
        b::VOL_DOWN,
    ],

    b::SEP,

    ButtonGroup[
        b::NEXT,
        b::PREV,
    ],

    b::SEP,

    ButtonGroup[
        b::RANDOM,
        b::REPEAT,
        b::CLEAR,
    ],

    b::SEP,
].map{|item|
    item.to_html
}.join

page do
    header + items
end
