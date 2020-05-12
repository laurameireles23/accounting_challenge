Rails.application.routes.draw do
  namespace 'api' do
  	namespace 'v1' do
      resources :accounts, only: %i[create show], param: :number
  	end
  end
end