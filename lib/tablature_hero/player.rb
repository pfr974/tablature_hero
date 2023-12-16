# frozen_string_literal: true

module TablatureHero
  module Player
    def self.play(filename)
      path = File.join(File.dirname(__FILE__), "..","..", "media", filename)
      `afplay #{path}.mp3`
    end
  end 
end
