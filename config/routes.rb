Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # Books-----------------------------------------
  match "books/get_books", to: "books#get_books", via: "post"
  match "books/create", to: "books#create", via: "post"
  match "books/delete_book", to: "books#delete_book", via: "post"
  match "books/update_book", to: "books#update_book", via: "post"

  # Students--------------------------------------
  match "students/create", to: "students#create", via: "post"
  match "students/get_students", to: "students#get_students", via: "get"
  match "students/edit_students", to: "students#edit_students", via: "post"
  match "students/delete_student", to: "students#delete_student", via: "post"
end
