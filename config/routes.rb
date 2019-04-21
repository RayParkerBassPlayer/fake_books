Rails.application.routes.draw do
  post "/find", :to => "home#find", :as => :find_tune
  root :to => "home#home"
end
