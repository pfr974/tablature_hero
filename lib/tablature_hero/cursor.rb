# frozen_string_literal: true

module TablatureHero
  class Cursor
    attr_accessor :section_index, :bar_index, :note_index, :string_index

    def initialize(song)
      @song = song
      @section_index = 0
      @bar_index = 0
      @note_index = 0
      @string_index = 0
    end

    def current_note
      @song[@section_index][:bars][@bar_index][@string_index][@note_index]
    rescue StandardError
      nil
    end

    def next_note
      @note_index += 1
      return unless @note_index >= @song[@section_index][:bars][@bar_index][@string_index].length

      @note_index = 0
      next_bar
    end

    def next_bar
      @bar_index += 1
      return unless @bar_index >= @song[@section_index][:bars].length

      @bar_index = 0
      next_section
    end

    def current_bar?(section_index, bar_index)
      @section_index == section_index && @bar_index == bar_index
    end

    def next_section
      @section_index += 1
      return unless @section_index >= @song.length

      @section_index = 0
    end

    def next_string
      @string_index += 1
      # We assume a 6 strings guitar for now...
      return unless @string_index >= 6

      @string_index = 0
      next_note
    end

    def change_note
      next_note
    end

    def reset
      @section_index = 0
      @bar_index = 0
      @note_index = 0
      @string_index = 0
    end
  end
end
