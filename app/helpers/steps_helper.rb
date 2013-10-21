module StepsHelper

	def availability_time_options
		[	"Weekday mornings (~ 9-11 am)", 
			"Weekday afternoons (~1:30-5 pm)",
			"Weekday evenings (~5:30-8pm)",
			"WeekEND mornings (~ 9-11 am)",
			"WeekEND afternoons (~1:30-5 pm)",
			"WeekEND evenings (~5:30-8pm)"	]
	end

	def runaway_desc_options
		[	"< 3 months",
			"3-6 months",
			"6 months - 1 year",
			"> year",
			"unlimited"	]
	end

	def startup_stage_options
		[	"customer discovery", 
			"solution validation",
			"scaling customer acquisition",
			"company building"	]
	end

	def startup_role_options
		[	"CEO",
			"CTO", 
			"product manager", 
			"UX/graphic designer", 
			"CMO/Marketing", 
			"Engineer"	]
	end

	def startup_market_options
		[	"B2C",
			"B2B",
			"B2G",
			"C2C",
			"others"	]
	end

	def startup_time_options
		[	"< 1 month",
			"1 - 6 months",
			"6 - 12 months",
			"> 1 year",
			"> 2 years"	]
	end

	def startup_interviews_options
		[	"< 5",
			"5-10",
			"10-20",
			"20-50",
			"50-100",
			">100"	]
	end

	def startup_customers_options
		[	"< 5",
			"5-10",
			"10-20",
			"20-50",
			"50-100",
			"100-200",
			"200-500",
			"500-1K",
			">1K"	]
	end															

end