# frozen_string_literal: true

require "curses"

module TablatureHero
  class Window
    def initialize
      # Curses settings
      Curses.init_screen
      Curses.start_color
      Curses.curs_set(0)
      Curses.noecho

      Curses.init_pair(0, 0, 0) # white
      Curses.init_pair(2, 2, 0) # green
      Curses.init_pair(5, 5, 0) # magenta
      Curses.init_pair(6, 6, 0) # cyan
      Curses.init_pair(8, 8, 0) # grey
      Curses.init_pair(9, 9, 0) # orange
      Curses.init_pair(11, 11, 0) # yellow

      @window = Curses::Window.new(0, 0, 1, 2)
      @window.nodelay = true
    end

    def reset
      @window.setpos(0, 0)
    end

    def print(content)
      @window << content
    end

    def newline
      @window << "\n"
    end

    def refresh
      (@window.maxy - @window.cury).times { @window.deleteln }
      @window.refresh
    end

    def get_char
      @window.getch.to_s
    end

    def highlight(content)
      color_pair = Curses.color_pair(2)
      @window.attron(color_pair) do
        @window << content
      end
      @window.attroff(color_pair)
    end
  end
end
