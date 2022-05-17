module HomeHelper
  def options_for_stations
    @options_for_stations ||= @stations.map { |e| [e["name"], e["abbr"]] }
  end

  def station_name(abbr)
    @stations_hash ||= options_for_stations.to_h.invert
    @stations_hash[abbr]
  end
end
