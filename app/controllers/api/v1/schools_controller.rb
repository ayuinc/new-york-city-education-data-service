module Api
  module V1
    class SchoolsController < ApplicationController

      def search_by_address
        schools = School.nearby_schools(params[:address], 2)
        render json: schools, status: 200
      end

      def search_by_name_or_dbn
        search_word = downcase_and_strip(params[:name_or_dbn])
        search_word_with_spaces = add_spaces(search_word)
        search_word_with_zeros = add_zeros(search_word_with_spaces)
        original_search = School.search_by_name_or_dbn(params[:name_or_dbn])
        schools = School.search_by_name_or_dbn(search_word_with_zeros)

        render json: schools.concat(original_search), status: 200
        render json: schools, status: 200
      end

      private

      def downcase_and_strip(phrase)
        phrase.downcase.gsub(/[^a-z0-9\s]/i, '')
      end

      def add_spaces(phrase)
        if phrase.match(/ps\S/ || /jsh\S/ || /ms\S/ || /is\S/)
          return phrase.insert(2, " ")
        elsif phrase.match(/jsh\s/)
          return phrase.insert(3, " ")
        else
          return phrase
        end
      end

      def add_zeros(phrase)
        numbers = phrase.match(/ps (\d+)/ || /ms (\d+)/ || /is (\d+)/)
        jsh_numbers = phrase.match(/jsh (\d+)/)
        phrase = phrase.split[0] + " "
        if numbers[1]
          (3 - numbers[1].length).times { phrase = phrase + "0" }
          phrase = phrase + numbers[1]
        elsif jsh_numbers[1]
          (3 - jsh_numbers[1].length).times { phrase = phrase + "0" }
          phrase = phrase + jsh_numbers[1]
        end
        return phrase
      end
    end
  end
end
