class HomeController < ApplicationController
  before_action :pull_stations

  def index
  end

  def trip_planner
    @start = params[:start]
    @end = params[:end]
    json = BartClient.get("/sched.aspx",
                          cmd: "arrive",
                          b: 0,
                          a: 1,
                          orig: params[:start],
                          dest: params[:end],
                         )
    trip = json["schedule"]["request"]["trip"]

    @trip_time = trip["@tripTime"]
    @arrives_at = trip["@destTimeMin"]
    @trip_legs = trip["leg"]
      .sort_by { |e| e["@order"] }
      .map do |e|
        route = e["@line"].split(" ").last
        json = BartClient.get("/route.aspx", cmd: "routeinfo", route: route)
        e.merge(json["routes"])
      end
  end

  private

  def pull_stations
    @stations ||= begin
      json = BartClient.get("/stn.aspx", cmd: "stns")
      json["stations"]["station"].map do |station|
        [station["name"], station["abbr"]]
      end
    end
  end
end
