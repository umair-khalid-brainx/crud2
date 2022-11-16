Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, :path_names => { :sign_up => "register"}
end
