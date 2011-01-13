class Range
    def clamp x
        [[x, self.begin].max, self.end].min
    end
end

class InitServlets
    EOL = "\n"

    def initialize server, mpd
        @server = server
        @mpd    = mpd

        # Percentage by which to increment volume
        @d_volume = 5

        # Maps "directories" on the server to methods in this class
        @mapping = {
            "prev"          => :prev,
            "next"          => :next,
            "stop"          => :stop,
            "pause"         => :pause,
            "play"          => :play,
            "playpause"     => :play_pause,
            "debug"         => :debug,
            "volup"         => :vol_up,
            "voldown"       => :vol_down,
            "nowplaying"    => :now_playing,
            "random"        => :random,
            "repeat"        => :repeat,
            "clear"         => :clear,
        }

        # Prefix to the "directories" above
        @prefix = "/api"
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
        @mpd.pause =  true
        resp.body  = "Pause"
    end

    def play req, resp
        @mpd.play
        resp.body = "Play"
    end

    def play_pause req, resp
        @mpd.pause =    ! @mpd.paused?
        @mpd.play    if ! @mpd.paused?
        resp.body  = if   @mpd.paused?
            then "Pause"
            else "Play"
        end
    end

    def vol_up req, resp
        vol_mod req, resp, +@d_volume
    end

    def vol_down req, resp
        vol_mod req, resp, -@d_volume
    end

    def vol_mod req, resp, d_vol
        old_vol     = @mpd.volume
        new_vol     = old_vol + d_vol
        @mpd.volume = (0 .. 100).clamp(new_vol) # monkey patched
        resp.body   = "Volume #{@mpd.volume}"
    end

    def now_playing req, resp
        song = @mpd.current_song

        stats = %w[title album artist time]
        stats.each do |stat|
            resp.body << stat << " " << song.send(stat) << EOL
        end
    end

    def random req, resp
        @mpd.random = ! @mpd.random?
        resp.body   = "Random"
    end

    def repeat req, resp
        @mpd.repeat = ! @mpd.repeat?
        resp.body   = "Repeat"
    end

    def clear req, resp
        @mpd.clear
        resp.body = "Clear"
    end

    def debug req, resp
        stats = @mpd.stats
        stats.each do |k, v|
            resp.body << "#{k}: #{v}" << EOL
        end
    end
end
