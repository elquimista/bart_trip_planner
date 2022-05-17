module HomeHelper
  def station_name(abbr)
    @stations_hash ||= @stations.to_h.invert
    @stations_hash[abbr]
  end
end
