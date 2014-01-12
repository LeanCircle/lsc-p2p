ActiveAdmin.register User do
  permit_params :email, :newsletter_subscription, :password, :password_confirmation

  index do
    column :name, sortable: :name do |user|
      link_to user.name, admin_user_path(user)
    end
    column :email, sortable: :email do |user|
      link_to user.email, "mailto:"+user.email
    end
    column :roles do |user|
      user.roles.map { |role| link_to(role.name, admin_role_path(role)) }.join(', ').html_safe
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

  show do
    attributes_table do
      row :id
      row :name
      row :email
      row :roles do |user|
        user.roles.map { |role| link_to(role.name, admin_role_path(role)) }.join(', ').html_safe
      end
      row :newsletter_subscription, sortable: :newsletter_subscription do |user|
            user.newsletter_subscription? ? status_tag( "True", :ok ) : status_tag( "False" )
          end
      row :stripe_customer_id, sortable: :stripe_customer_id do |user|
        user.stripe_customer_id? ? status_tag( "Yes", :ok ) : status_tag( "No" )
      end
      row :sign_in_count
      row :last_sign_in_at
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :newsletter_subscription, :as => :radio
      f.input :roles, :as => :check_boxes
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
