Rails.application.routes.draw do
  devise_for :users
  resources :todos
  post 'todos/active_inactive'
  post 'todos/status_update'
  # post 'todos/up_arrow'
  # post 'todos/down_arrow'
  post 'todos/change_position'
  post 'todos/search'
  post 'todos/track_status'
  post 'comments/create'
  post 'share/create_share'
  post 'user_profile/user_profile'
  post 'user_profile/edit_profile'
  post 'user_profile/update_profile'
  post 'user_profile/update_profile_pic'
  post 'user_profile/update'
  post 'todos/update'
  root 'todos#index'


  resources :pages do
  collection do
    get :new_idea
  end
end


resources :todo do
  resources :comments
end

resources :user_profile do
  member do
    delete :delete_image_attachment
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
