module StaticPagesHelper

	def nav_link(link_text, link_path)
		content_tag(:li, class: ('active' if current_page?(link_path))) do
			link_to link_text, link_path
		end
	end

	def team_members
		[

			{ name: "Spike",
				surname: "Morelli", 
				bio: "Engineer and bootstrapper. Seeking to help people from good to
							great and freedom through product development.",
				links: {
								website: "https://www.spikelab.org",
								twitter: "http://twitter.com/spikelab",
								linkedin: "http://www.linkedin.com/in/spikemorelli"
								}
			},
			
			{ name:"Tristan",
				surname:"Kromer",
				bio: "Boots on the ground. Moderates the discussion group. Builds
							the website. Blogs about 
							<a href='http://grasshopperherder.com'>lean startups and
							customer development</a>.",
				links: {
								website: "http://tristankromer.com/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								twitter: "http://tristankromer.com/twitter/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								linkedin: "http://tristankromer.com/linkedin/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								quora: "http://tristankromer.com/quora/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								angellist: "http://tristankromer.com/angellist/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								gplus: "http://tristankromer.com/googleplus/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								slideshare: "http://tristankromer.com/slideshare/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								skype: "skype:Tristan.Kromer",
								facebook: "http://tristankromer.com/facebook/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								pinterest: "http://tristankromer.com/pinterest/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage",
								chess: "http://tristankromer.com/chess/?utm_source=P2PC&utm_medium=web&utm_campaign=Team%2Bpage"
								}
			}

		]
	end
	
end