Rails.application.routes.draw do
  root to: 'items#index'
  get 'selects', to: 'items#select'
  get 'message_info', to: 'permits#index'
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  resources :items, only: %i[index]
  resources :users, only: %i[show edit update] do
    resources :items, only: %i[create new show edit update]
    resources :message_rooms, only: %i[index create destroy] do
      resources :messages, only: %i[index create destroy]
    end
    resources :permits, only: %i[new create] do
      collection do
        get 'check', to: 'permits#check'
        get 'edit', to: 'permits#edit'
        patch 'update', to: 'permits#update'
      end
    end
  end
  ActiveAdmin.routes(self)
end

# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                                  root GET    /                                                                                        items#index
#                               selects GET    /selects(.:format)                                                                       items#select
#                      new_user_session GET    /users/sign_in(.:format)                                                                 devise/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 devise/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                devise/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                new_admin_user_session GET    /admin/login(.:format)                                                                   active_admin/devise/sessions#new
#                    admin_user_session POST   /admin/login(.:format)                                                                   active_admin/devise/sessions#create
#            destroy_admin_user_session DELETE /admin/logout(.:format)                                                                  active_admin/devise/sessions#destroy
#               new_admin_user_password GET    /admin/password/new(.:format)                                                            active_admin/devise/passwords#new
#              edit_admin_user_password GET    /admin/password/edit(.:format)                                                           active_admin/devise/passwords#edit
#                   admin_user_password PATCH  /admin/password(.:format)                                                                active_admin/devise/passwords#update
#                                       PUT    /admin/password(.:format)                                                                active_admin/devise/passwords#update
#                                       POST   /admin/password(.:format)                                                                active_admin/devise/passwords#create
#                                 items GET    /items(.:format)                                                                         items#index
#                            user_items POST   /users/:user_id/items(.:format)                                                          items#create
#                         new_user_item GET    /users/:user_id/items/new(.:format)                                                      items#new
#                        edit_user_item GET    /users/:user_id/items/:id/edit(.:format)                                                 items#edit
#                             user_item GET    /users/:user_id/items/:id(.:format)                                                      items#show
#                                       PATCH  /users/:user_id/items/:id(.:format)                                                      items#update
#                                       PUT    /users/:user_id/items/:id(.:format)                                                      items#update
#                    user_room_messages GET    /users/:user_id/rooms/:room_id/messages(.:format)                                        messages#index
#                                       POST   /users/:user_id/rooms/:room_id/messages(.:format)                                        messages#create
#                            user_rooms GET    /users/:user_id/rooms(.:format)                                                          rooms#index
#                                       POST   /users/:user_id/rooms(.:format)                                                          rooms#create
#                             user_room DELETE /users/:user_id/rooms/:id(.:format)                                                      rooms#destroy
#                             edit_user GET    /users/:id/edit(.:format)                                                                users#edit
#                                  user GET    /users/:id(.:format)                                                                     users#show
#                                       PATCH  /users/:id(.:format)                                                                     users#update
#                                       PUT    /users/:id(.:format)                                                                     users#update
#                            admin_root GET    /admin(.:format)                                                                         admin/dashboard#index
#        batch_action_admin_admin_users POST   /admin/admin_users/batch_action(.:format)                                                admin/admin_users#batch_action
#                     admin_admin_users GET    /admin/admin_users(.:format)                                                             admin/admin_users#index
#                                       POST   /admin/admin_users(.:format)                                                             admin/admin_users#create
#                  new_admin_admin_user GET    /admin/admin_users/new(.:format)                                                         admin/admin_users#new
#                 edit_admin_admin_user GET    /admin/admin_users/:id/edit(.:format)                                                    admin/admin_users#edit
#                      admin_admin_user GET    /admin/admin_users/:id(.:format)                                                         admin/admin_users#show
#                                       PATCH  /admin/admin_users/:id(.:format)                                                         admin/admin_users#update
#                                       PUT    /admin/admin_users/:id(.:format)                                                         admin/admin_users#update
#                                       DELETE /admin/admin_users/:id(.:format)                                                         admin/admin_users#destroy
#                       admin_dashboard GET    /admin/dashboard(.:format)                                                               admin/dashboard#index
#              batch_action_admin_users POST   /admin/users/batch_action(.:format)                                                      admin/users#batch_action
#                           admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                                       POST   /admin/users(.:format)                                                                   admin/users#create
#                        new_admin_user GET    /admin/users/new(.:format)                                                               admin/users#new
#                       edit_admin_user GET    /admin/users/:id/edit(.:format)                                                          admin/users#edit
#                            admin_user GET    /admin/users/:id(.:format)                                                               admin/users#show
#                                       PATCH  /admin/users/:id(.:format)                                                               admin/users#update
#                                       PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                                       DELETE /admin/users/:id(.:format)                                                               admin/users#destroy
#                        admin_comments GET    /admin/comments(.:format)                                                                admin/comments#index
#                                       POST   /admin/comments(.:format)                                                                admin/comments#create
#                         admin_comment GET    /admin/comments/:id(.:format)                                                            admin/comments#show
#                                       DELETE /admin/comments/:id(.:format)                                                            admin/comments#destroy
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create
