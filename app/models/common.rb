module Common
  extend ActiveSupport::Concern

  included do
    after_create { |item| item.assign_role_to_owner(item.role_id) }
  end

  protected
    def assign_role_to_owner(id)
      self.user.role_assignments.create(role_id: id)
    end
end