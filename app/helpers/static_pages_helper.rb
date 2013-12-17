module StaticPagesHelper

	def nav_link(link_text, link_path, target=nil)
		content_tag(:li, class: ('active' if current_page?(link_path))) do
			link_to link_text, link_path, target: target
		end
	end
	
end