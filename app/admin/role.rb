ActiveAdmin.register Role do
  permit_params :name

  index do
    selectable_column
    column :name, sortable: :name do |role|
      link_to role.name, admin_role_path(role)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

  sidebar "Users with role", only: :show do
    table_for role.users do
      column "name" do |user|
        link_to user.name, admin_user_path(user)
      end
    end
  end

  form do |f|
    f.inputs "Details" do
      f.input :name
    end
    f.actions
  end

end
