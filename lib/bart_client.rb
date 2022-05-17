module BartClient
  BASE_URL = "http://api.bart.gov/api"
  API_KEY = "MW9S-E7SL-26DU-VV8V"

  def self.get(path, query = {})
    default_query = {
      json: "y",
      key: API_KEY,
    }
    response = HTTParty.get(
      "#{BASE_URL}/#{path}",
      query: default_query.merge(query)
    )
    response.parsed_response["root"]
  end
end
