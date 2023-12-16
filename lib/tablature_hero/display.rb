# frozen_string_literal: true

require_relative "player"
require_relative "window"

module TablatureHero
  module Display
    def self.start(song)      
      window = TablatureHero::Window.new

      song.each do |section|
        beat_duration = 60.0 / section[:tempo].to_i
        time_signature = TablatureHero::TIME_SIGNATURES[section[:time_signature]]        
        current_bar = time_signature.clone
        bars_remaining = section[:bars].count

        loop do
          window.reset
          6.times do
            window.print "|" if current_bar == time_signature
            current_bar.each { |_note| window.print "--" }
            10.times do
              window.print "|"
              time_signature.each { |_note| window.print "--" }
            end
            window.newline
          end
          window.refresh
        
          note = current_bar.shift
          Thread.new { TablatureHero::Player.play("metro_#{note}") }
        
          case window.get_char
          when "q"
            exit
          end
          sleep beat_duration
          if current_bar.empty?
            bars_remaining -= 1
            break if bars_remaining == 0
            current_bar = time_signature.clone
          end
        end
      end
    end
  end 
end