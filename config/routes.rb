ActionController::Routing::Routes.draw do |map|

  map.resources :tasks, :only => [:index, :show, :new, :create], :member => { :finish => :put }

end
