Rails.application.routes.draw do
  post "/find", :to => "home#find", :as => :find_tune
  get "/find", :to => "home#home", :as => :home_home
  get "/ireal_import/:id", :to => "home#i_real_import", :as => :i_real_import

  root :to => "home#home"
  match '*path' => 'home#find', via: :all
end
