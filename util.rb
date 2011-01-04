class Util
end

Util.instance_eval do
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
        meta "HandheldFriendly", "true"
    end

    def title text, cgi=$cgi
        cgi.title{text}
    end
end
