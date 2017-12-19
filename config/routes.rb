Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  resources :exams
  resources :quiz

  get '/exams/:id/take', to: "exams#take", as: "exams_take"
  post '/exams/submit_quiz', to: "exams#submit_quiz", as: "exams_submit_quiz"

end
