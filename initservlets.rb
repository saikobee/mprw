class InitServlets
    def initialize server, mpd
        @server = server
        @mpd    = mpd

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
        @mpd.previous
        resp.body = "Previous"
    end

    def next req, resp
        @mpd.next
        resp.body = "Next"
    end

    def stop req, resp
        @mpd.stop
        resp.body = "Stop"
    end

    def pause req, resp
        @mpd.pause = true
        resp.body = "Pause"
    end

    def play req, resp
        @mpd.play
        resp.body = "Play"
    end

    def toggle req, resp
        @mpd.pause = ! @mpd.paused?
        resp.body  = "Toggle"
    end

    def debug req, resp
        stats = @mpd.stats
        stats.each do |k, v|
            resp.body << "#{k}: #{v}" << "\n"
        end
    end
end
