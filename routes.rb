Rails.application.routes.draw do
  namespace :admin do

    scope controller: :user_portals, path: 'user_portals', as: 'user_portals' do
      get :index
      match :create, via: %i[get post]
      match :update, via: %i[get patch]
      get :reports
    end
  end
end
