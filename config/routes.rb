Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :headlines do
        resources :comments
      end
    end
  end
end
