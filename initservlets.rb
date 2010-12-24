class InitServlets
    def initialize server
        @server = server

        # Maps "directories" on the server to methods in this class
        @mapping = {
            "prev"      => :prev,
            "next"      => :next,
            "stop"      => :stop,
            "pause"     => :pause,
            "play"      => :play,
            "toggle"    => :toggle,
            "debug"     => :debug,
        }

        # Prefix to the "directories" above
        @prefix = "/message"
    end

    def load
        @mapping.each do |k, v|
            dir = @prefix + "/" + k
            fun = method v

            @server.mount_proc dir, fun
        end
    end

    def prev req, resp
        resp.body = "Previous"
    end

    def next req, resp
        resp.body = "Next"
    end

    def stop req, resp
        resp.body = "Stop"
    end

    def pause req, resp
        resp.body = "Pause"
    end

    def play req, resp
        resp.body = "Play"
    end

    def toggle req, resp
        resp.body = "Toggle"
    end

    def debug req, resp
        resp.content_type = "text/html"
        resp.body = <<EOF
<code>
[[[
<pre>
Just a simple test right now :D
Boy, I sure do love Ruby!
</pre>
]]]
</code>
EOF
    end
end
