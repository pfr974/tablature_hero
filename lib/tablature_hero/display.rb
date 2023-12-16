# frozen_string_literal: true

module TablatureHero
  module Display
    def self.start(time_signature, tempo)
      beat_duration = 60.0 / tempo.to_i
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
      
      window = Curses::Window.new(0, 0, 1, 2)
      window.nodelay = true
      
      current_bar = time_signature.clone
      loop do
        window.setpos(0, 0)
        6.times do
          window << "|" if current_bar == time_signature
          current_bar.each { |_note| window << "--" }
          10.times do
            window << "|"
            time_signature.each { |_note| window << "--" }
          end
          window << "\n"
        end
        (window.maxy - window.cury).times { window.deleteln }
        window.refresh
      
        note = current_bar.shift
        Thread.new { TablatureHero::Player.play("metro_#{note}") }
      
        case window.getch.to_s
        when "q"
          break
        end
        sleep beat_duration
        current_bar = time_signature.clone if current_bar.empty?
      end
    end
  end 
end