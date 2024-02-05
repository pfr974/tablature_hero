# frozen_string_literal: true

require_relative "tablature_hero/version"
require_relative "tablature_hero/display"

module TablatureHero
  TIME_SIGNATURES = {
    "2/4" => %i[high low],
    "3/4" => %i[high low low],
    "4/4" => %i[high low low low],
    "5/4" => %i[high low low low low],
    "3/8" => %i[high low low],
    "6/8" => %i[high low low high low low]
  }.freeze
end
