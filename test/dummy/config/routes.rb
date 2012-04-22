Rails.application.routes.draw do
  root :to => 'home#index'
  scope :module => "let_me_in" do
    LetMeIn::Routes.draw(self)
  end
end
