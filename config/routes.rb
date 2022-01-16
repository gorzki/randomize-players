Rails.application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  root to: 'solitaire#new'
  resources :solitaire, only: %i[new create] do
    collection do
      get :download_output
    end
  end
end
