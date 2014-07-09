require 'net/http'
require 'json'

module NewYorkEducation
  class ApiJsonParser

    @@base_url = 'http://162.243.110.154/api/v1/school/'

    def initialize(school_id)
      @school_id = school_id
    end

    def records
      resp = Net::HTTP.get_response(URI.parse(@@base_url + @school_id)) 
      JSON.parse(resp.body)
    end
  end
end
