Rails.application.routes.draw do
    root "users#login"

    # users
    post '/users/login_handle' => 'users#login_handle'
    get '/users/register' => 'users#register'
    post '/users/register_handle' => 'users#register_handle'
    get '/users/login' => 'users#login'

    #messages
    get '/messages' => 'messages#index'
    post '/messages/message_handle' => 'messages#message_handle'
    get  '/destroy/messages/:id' => 'messages#destroy', as: :destroy_message
    get '/messages/:message_id/comments' => 'comments#comment', as: :message_comments
    post '/messages/:message_id/comments' => 'comments#comment_handle', as: :create_message_comment
    # get '/users/login' => 'users#login'
    get 'messages/index' => 'messages#index'

    # comments
    get  '/destroy/comments/:id' => 'comments#destroy', as: :destroy_comment
    
end
