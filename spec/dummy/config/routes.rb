Rails.application.routes.draw do

  resources :monkies, :ninjas

  resources :apples do
    resources :chickens
  end

end
