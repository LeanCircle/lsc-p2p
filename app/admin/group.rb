ActiveAdmin.register Group do
  permit_params :name, :user_id, :description, :approval, :lsc, :city, :province, :country,
                :meetup_link, :facebook_link, :twitter_link, :linkedin_link, :googleplus_link, :other_link

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  index do
    selectable_column
    column :name, sortable: :name do |group|
      link_to group.name, admin_group_path(group)
    end
    column "Organizer" do |group|
      link_to_unless(group.user.nil?, group.user.try(:name), admin_user_path(group.user))
    end
    column :address, sortable: :country
    column do |group|
      link_to_unless(group.meetup_link.blank?, "#{image_tag 'links/link_meetup.png', width: '25px'}".html_safe, group.meetup_link, target: "_blank"){}
    end
    column do |group|
      link_to_unless(group.facebook_link.blank?, "#{image_tag 'links/link_facebook.png', width: '25px'}".html_safe, group.facebook_link, target: "_blank"){}
    end
    column do |group|
      link_to_unless(group.linkedin_link.blank?, "#{image_tag 'links/link_linkedin.png', width: '25px'}".html_safe, group.linkedin_link, target: "_blank"){}
    end
    column do |group|
      link_to_unless(group.twitter_link.blank?, "#{image_tag 'links/link_twitter.png', width: '25px'}".html_safe, group.twitter_link, target: "_blank"){}
    end
    column do |group|
      link_to_unless(group.googleplus_link.blank?, "#{image_tag 'links/link_googleplus.png', width: '25px'}".html_safe, group.googleplus_link, target: "_blank"){}
    end
    column do |group|
      link_to_unless(group.other_link.blank?, "#{image_tag 'links/link_home_black.png', width: '25px'}".html_safe, group.other_link, target: "_blank"){}
    end
    column "Lng & Lat", sortable: :country do |group|
      group.longitude? && group.latitude? ? "Yes" : "No"
    end
    column :approval, sortable: :approval do |group|
      link_to group.approval.to_s, toggle_approval_admin_group_path(group), method: :put
    end
    column :lsc, sortable: :lsc do |group|
      link_to group.lsc.to_s, toggle_lsc_admin_group_path(group), method: :put
    end
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :name
      f.input :description
      f.input :user
    end
    f.inputs 'Status' do
      f.input :approval, as: :radio
      f.input :lsc, as: :radio
    end
    f.inputs 'Location' do
      f.input :city
      f.input :province
      f.input :country, as: :string
    end
    f.inputs 'Links' do
      f.input :meetup_link
      f.input :facebook_link
      f.input :twitter_link
      f.input :linkedin_link
      f.input :googleplus_link
      f.input :other_link
    end
    f.actions
  end

  member_action :toggle_approval, method: :put do
    resource.approval? ? value = false : value = true
    resource.update(:approval => value)
    redirect_to admin_groups_path, notice: "Approval for " + resource.name + " changed to " + value.to_s
  end

  member_action :toggle_lsc, method: :put do
    resource.lsc? ? value = false : value = true
    resource.update(:lsc => value)
    redirect_to admin_groups_path, notice: "LSC status for " + resource.name + " changed to " + value.to_s
  end

  action_item only: :show do
    link_to "Toggle Approval", toggle_approval_admin_group_path(group), method: :put
  end

  action_item only: :show do
    link_to "Toggle LSC Status", toggle_lsc_admin_group_path(group), method: :put
  end

end