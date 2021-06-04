ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :nickname, :birthday, :blood_type_id, :profile, :impressions_count

  remove_filter :start_time, :end_time, :created_at, :updated_at

  form do |f|
    f.inputs do
      f.input :nickname
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :nickname, :birthday, :blood_type_id, :profile, :impressions_count, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :nickname, :birthday, :blood_type_id, :profile, :impressions_count, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
