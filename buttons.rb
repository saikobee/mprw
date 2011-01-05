require "ostruct"

class Separator
    def to_html cgi=$cgi
        cgi.div :class => "separator"
    end
end

class Button < OpenStruct
    def to_html cgi=$cgi
        cgi.div :class => "button_border #{klass}" do
            cgi.div :class => "button" do
                cgi.p(:class => "label"      ){name} +
                cgi.p(:class => "description"){desc}
            end
        end
    end

    def with data
        dup.with! data
    end

    def with! data
        @table.merge! data
        self
    end
end

class ButtonGroup
    def initialize *args
        @buttons = args
    end

    def self.[] *args
        ButtonGroup.new *args
    end

    def to_html cgi=$cgi
        len = @buttons.length
        return "" if len == 0

        top = @buttons.first.with(:klass => "solo").to_html
        return top if len == 1

        top = @buttons.first.with(:klass => "top"   ).to_html
        bot = @buttons.last .with(:klass => "bottom").to_html
        return top + bot if len == 2

        mid = @buttons[1 .. -2].map{|button|
            button.with(:klass => "middle").to_html
        }.join
        return top + mid + bot
    end
end

class Buttons
    PLAY_PAUSE = Button.new(
        :name  => "Play/Pause",
        :desc  => "Toggles playback",
        :id    => "playpause"
    )

    VOL_UP = Button.new(
        :name  => "Louder",
        :desc  => "Raises the volume",
        :id    => "volup"
    )

    VOL_DOWN = Button.new(
        :name  => "Quieter",
        :desc  => "Lowers the volume",
        :id    => "voldown"
    )

    NEXT = Button.new(
        :name  => "Next",
        :desc  => "Switches to the next track",
        :id    => "next"
    )

    PREV = Button.new(
        :name  => "Previous",
        :desc  => "Switches to the previous track",
        :id    => "prev"
    )

    RANDOM = Button.new(
        :name  => "Random",
        :desc  => "Randomizes the playlist play order",
        :id    => "random"
    )

    REPEAT = Button.new(
        :name  => "Repeat",
        :desc  => "Repeats the playlist when finished",
        :id    => "repeat"
    )

    CLEAR = Button.new(
        :name  => "Clear",
        :desc  => "Clears the playlist",
        :id    => "clear"
    )

    SEP = Separator.new
end
