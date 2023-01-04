Rails.application.routes.draw do
  resources :slots do
    collection do
      post :save_slots_and_capacity
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
