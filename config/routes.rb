Rails.application.routes.draw do
  root :to => "powerade#read"
  
  get ":controller(/:action(/:id))"
  post ":controller(/:action(/:id))"
  
end
