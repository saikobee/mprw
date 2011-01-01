class Separator
    def to_html cgi=$cgi
        cgi.br
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
end

module Buttons
    PLAY_PAUSE = Button.new(
        :klass => "solo",
        :name  => "Play/Pause",
        :desc  => "Toggles playback",
        :id    => "playpause"
    )

    VOL_UP = Button.new(
        :klass => "top",
        :name  => "Louder",
        :desc  => "Raises the volume",
        :id    => "volup"
    )

    VOL_DOWN = Button.new(
        :klass => "bottom",
        :name  => "Quieter",
        :desc  => "Lowers the volume",
        :id    => "voldown"
    )

    NEXT = Button.new(
        :klass => "top",
        :name  => "Next",
        :desc  => "Switches to the next track",
        :id    => "next"
    )

    PREV = Button.new(
        :klass => "bottom",
        :name  => "Previous",
        :desc  => "Switches to the previous track",
        :id    => "prev"
    )

    RANDOM = Button.new(
        :klass => "top",
        :name  => "Random",
        :desc  => "Randomizes the playlist play order",
        :id    => "random"
    )

    REPEAT = Button.new(
        :klass => "middle",
        :name  => "Repeat",
        :desc  => "Repeats the playlist when finished",
        :id    => "repeat"
    )

    CLEAR = Button.new(
        :klass => "bottom",
        :name  => "Clear",
        :desc  => "Clears the playlist",
        :id    => "clear"
    )

    SEP = Separator.new
end
