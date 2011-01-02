#!/usr/bin/ruby

require "cgi"

require "./buttons.rb"

$cgi = cgi = CGI.new("html4")

def css sheet, cgi=$cgi
    cgi.link(
        :rel  => "stylesheet",
        :type => "text/css",
        :href => sheet
    )
end

def script src, cgi=$cgi
    cgi.script(
        :type => "text/javascript",
        :src  => src
    )
end

def utf8 cgi=$cgi
    cgi.meta(
        :'http-equiv' => "Content-Type",
        :content      => "text/html; charset=UTF-8"
    )
end

def meta name, content, cgi=$cgi
    cgi.meta(
        :name    => name,
        :content => content
    )
end

def android_fix cgi=$cgi
    meta "HandheldFriendly", "true", cgi
end

def header cgi=$cgi
    cgi.div :class => "banner_border" do
        cgi.h1 :class => "banner" do
            "mprw &ndash; mpd web remote"
        end
    end
end

def head cgi=$cgi
    cgi.head do
        cgi.title{"mprw - mpd web remote"} +
        css("main.css") +
        css("themes/dark.css") +
        script("main.js") +
        android_fix +
        utf8
    end
end

def page cgi=$cgi
    cgi.out do
        cgi.html do
            head +
            cgi.body do
                "\n" + yield
            end
        end
    end
end

items = [
    Buttons::SEP,

    ButtonGroup[
        Buttons::PLAY_PAUSE,
    ],

    Buttons::SEP,

    ButtonGroup[
        Buttons::VOL_UP,
        Buttons::VOL_DOWN,
    ],

    Buttons::SEP,

    ButtonGroup[
        Buttons::NEXT,
        Buttons::PREV,
    ],

    Buttons::SEP,

    ButtonGroup[
        Buttons::RANDOM,
        Buttons::REPEAT,
        Buttons::CLEAR,
    ],

    Buttons::SEP,
].map{|item|
    item.to_html
}.join

page do
    header + items
end
