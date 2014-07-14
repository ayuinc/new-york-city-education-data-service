Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/schools/search_by_address', to: 'schools#search_by_address'
      get '/schools/search_by_name_or_dbn', to: 'schools#search_by_name_or_dbn'
    end
  end
end
