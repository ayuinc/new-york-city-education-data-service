module Api
  module V1
    class SchoolsController < ApplicationController

      def search_by_address
        schools = School.nearby_schools(params[:address], 2).limit(30)
        render json: schools, status: 200
      end

      def search_by_name_or_dbn
        if params[:name_or_dbn].match(/ps\S/)
          schools = School.search_by_name_or_dbn(params[:name_or_dbn].gsub(/ps\S/i) do |s|
            s.insert(2, " 00")
            s.insert(1, ".")
          end
          )
          schools.limit(30)
        else
          schools = School.search_by_name_or_dbn(params[:name_or_dbn].gsub(/^ps/i, "p.s. ")).limit(30)
        end

        render json: schools, status: 200
      end
    end
  end
end
