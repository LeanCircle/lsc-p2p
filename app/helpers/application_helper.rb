module ApplicationHelper

	def full_title(page_title)
		base_title = "P2PC"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

  def ga_tracking
    flash[:tracking].map do |event|
      "_gaq.push(#{raw event.to_json});"
    end.join("\n")
  end

end
