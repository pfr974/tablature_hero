# frozen_string_literal: true

require_relative "player"
require_relative "window"

module TablatureHero
  module Display
    def self.start(song)      
      window = TablatureHero::Window.new

      section_index = 0
      bar_index = 0
      note_index = 0

      loop do
        window.reset
        6.times do |string_index|
          song.each do |section| 
            #beat_duration = 60.0 / section[:tempo].to_i
            #time_signature = TablatureHero::TIME_SIGNATURES[section[:time_signature]]        
            #bars_remaining = section[:bars].count

            section[:bars].each do |bar|
              window.print "|"
              bar[string_index].each do |note|
                window.print " #{note} "
              end
                # Thread.new { TablatureHero::Player.play("metro_#{time_signature[index]}") }
            end
          end
          window.newline
        end
        window.refresh

        case window.get_char
        when "q"
          exit
        end
        sleep 1
      end
    end
  end 
end