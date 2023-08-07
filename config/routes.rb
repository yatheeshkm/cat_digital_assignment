Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


  get '/user' => "user#user"
  get '/add_user' => "user#add_user"
  post '/create_user' => "user#create_user"
  get '/user/edituser/:id' => "user#edit_user", :as => 'user_edit'
  put '/update_user' => "user#update_user", :as =>'user_update'
  delete 'user/deleteuser/:id' => "user#delete_user", :as => 'user_delete'
end
