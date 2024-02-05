# frozen_string_literal: true

require_relative "player"
require_relative "window"
require_relative "cursor"

module TablatureHero
  module Display
    def self.start(song)      
      window = TablatureHero::Window.new
      cursor = TablatureHero::Cursor.new(song)
      
      loop do
        window.reset
        6.times do |string_index|
          song.each_with_index do |section, section_index| 
            section[:bars].each_with_index do |bar, bar_index|
              window.print "|"
              if cursor.current_bar?(section_index, bar_index)
                bar[string_index].each do |note|
                  window.highlight(" #{note} ")
                end
              else
                bar[string_index].each do |note|
                  window.print(" #{note} ")
                end
              end
            end
          end
          window.newline
        end
        window.refresh

        case window.get_char
        when "q"
          exit
        end
        cursor.change_note
        sleep 1
      end
    end
  end 
end