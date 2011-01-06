require "ostruct"

class Separator
    def to_html cgi=$cgi
        cgi.div :class => "separator"
    end
end

class Button < OpenStruct
    ON_CLICK = "on_button_click(this)"

    def to_html cgi=$cgi
        cgi.div(
            :class   => "button_border #{klass}",
            :id      => id,
            :onclick => ON_CLICK
        ) do
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

    def make klass
        with(:klass => klass).to_html
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
        return case @buttons.length
        when 0
            ""
        when 1
            @buttons.first.make("solo")
        when 2
            @buttons.first.make("top") +
            @buttons.last .make("bottom")
        else
            @buttons.first.make("top") +
            @buttons[1 .. -2].map{|button| button.make("middle")}.join +
            @buttons.last.make("bottom")
        end
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
