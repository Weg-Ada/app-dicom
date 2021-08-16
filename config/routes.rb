Rails.application.routes.draw do
  get 'home/index'
  resources :examinations
  resources :patients
  get 'home' => 'home#index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  get 'examinations/:id/image/:disp', to: 'examinations#image', as: 'show_image'
  get 'sessions/create'
  get 'sessions/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
end
