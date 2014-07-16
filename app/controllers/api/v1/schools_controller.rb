module Api
  module V1
    class SchoolsController < ApplicationController

      def search_by_address
        schools = School.nearby_schools(params[:address], 2).limit(30)
        render json: schools, status: 200
      end

      def search_by_name_or_dbn
        schools = School.search_by_name_or_dbn(params[:name_or_dbn].gsub(/ps /i, "p.s. ")).limit(30)
        render json: schools, status: 200
      end
    end
  end
end
