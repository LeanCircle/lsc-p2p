ActiveAdmin.register Event do

  controller do
    def scoped_collection
      super.includes :group
    end
  end

  index do
    selectable_column

    column "Group", sortable: 'groups.name' do |event|
      link_to_unless(event.group.blank?, event.group.try(:name), admin_group_path(event.group))
    end
    column :start_datetime
    column :link do |event|
      link_to event.event_url
    end
    actions
  end


end
