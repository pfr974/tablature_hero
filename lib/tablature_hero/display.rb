# frozen_string_literal: true

require_relative "player"
require_relative "window"

module TablatureHero
  module Display
    def self.start(time_signature, tempo)      
      beat_duration = 60.0 / tempo.to_i
      
      window = TablatureHero::Window.new

      current_bar = time_signature.clone
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
          break
        end
        sleep beat_duration
        current_bar = time_signature.clone if current_bar.empty?
      end
    end
  end 
end