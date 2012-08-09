Guru::Application.routes.draw do
  
  get  '/members/invitatation/accept/:hash',     :controller => :members, :action => :acceptinvitation
  get  '/counselors/for_camp/:camp_id', :to => 'counselors#for_camp', :as => 'counselors_for_camp'
  get  '/reviews/addreviewfromcsv',     :controller => :reviews, :action => :addreviewfromcsv
  get  '/events/get_events',     :controller => :events, :action => :get_events
  get  '/events/edit',     :controller => :events, :action => :edit
  get  '/events/json/:camp',     :controller => :events, :action => :index
  get  '/activities/json/:camp', :controller => :activities, :action => :index
  get  '/activities/new/:id', :controller => :activities, :action => :new
  get  '/links',            :controller => :camps,  :action => :kaminari
  post '/optins',           :controller => :optins, :action => :create
  get  '/home/about', :controller => :home, :action => :about, :as => 'home_about'
  get  '/home/comingsoon', :controller => :home, :action => :comingsoon, :as => 'home_comingsoon'
  get  '/home/index', :controller => :home, :action => :index, :as => 'home_index'
  get  '/surveys/splash', :controller => :surveys, :action => :splash, :as => 'splash_page'
  get  'surveys/music_together_of_charlotte', :controller => :surveys, :action => :music_together_of_charlotte
  get  'surveys/kidville', :controller => :surveys, :action => :kidville
  get  'surveys/city_treehouse', :controller => :surveys, :action => :city_treehouse
  get  'surveys/boys_and_girls_club_of_america', :controller => :surveys, :action => :boys_and_girls_club_of_america
  get  'surveys/boy_scouts_of_america', :controller => :surveys, :action => :boy_scouts_of_america
  get  'surveys/girl_scouts', :controller => :surveys, :action => :girl_scouts
  get  'surveys/ymcanyc', :controller => :surveys, :action => :ymcanyc
  get  'surveys/jccmanhattan', :controller => :surveys, :action => :jccmanhattan
  
  
  resources :deals
  resources :wishes
  resources :orders
  resources :reviews
  resources :kids
  resources :groups
  resources :counselors 
  resources :members
  resources :posts
  resources :surveys
  resources :events
  resources :activities
  resources :camps do
    resources :surveys
  end
  resources :mastercamps
  resources :categories
  resources :directorforms
  resources :assets
  
  resources :zip, :only => [:index]
  resources :city, :only => [:index]
  
  ActiveAdmin.routes(self)
  
  post '/admin/mastercamps/change_subs',           :controller => 'admin/mastercamps', :action => :change_subs
  
  devise_for :users, :controllers => { 
          :sessions => 'sessions', 
          :registrations => 'registrations',
          :omniauth_callbacks => "omniauth_callbacks"
          }
  
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_scope :user do
    get '/users/auth/:provider' => 'omniauth_callbacks#passthru'
  end
  
  match ':controller(/:action(/:id))'

  root :to => 'home#index'
  

  #Last route in routes.rb
  unless Rails.application.config.consider_all_requests_local
    match '*a', :to => 'errors#error_404'
  end
end
