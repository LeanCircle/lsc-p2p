module ApplicationHelper

	def full_title(page_title)
		base_title = "Lean Startup Circle"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
	end

  def bootstrap_class_for flash_type
    { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
  end

end
