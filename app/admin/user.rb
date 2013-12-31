ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation

  index do
    column :name, sortable: :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email, sortable: :email do |user|
      link_to user.email, "mailto:"+user.email
    end
    column :newsletter_subscription, sortable: :newsletter_subscription do |user|
      user.newsletter_subscription? ? status_tag( "True", :ok ) : status_tag( "False" )
    end
    column :stripe_customer_id, sortable: :stripe_customer_id do |user|
      user.stripe_customer_id? ? status_tag( "Yes", :ok ) : status_tag( "No" )
    end
    column :last_sign_in_at
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :newsletter_subscription, :as => :radio # TODO: This doesn't seem to be working.
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
