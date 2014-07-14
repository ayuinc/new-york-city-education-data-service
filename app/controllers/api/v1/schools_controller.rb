module Api
  module V1
    class SchoolsController < ApplicationController

      def search_by_address
        schools = School.nearby_schools(params[:address], 2)
        render json: schools, status: 200
      end
    end
  end
end
