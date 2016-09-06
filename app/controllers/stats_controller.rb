class StatsController < ApplicationController
	def index
	@user		  		=	User.find(current_user.id)
	@schedules    		= 	@user.schedules
	@schedules_month    = 	@user.schedules.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_month)
	end
	def admin_index
		@users_active =	User.where(last_login: (Time.now.beginning_of_month)..Time.now.end_of_day)
		@users_new 	  =	User.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_day)
		@users_total  =	User.all
		@courtesis_month = Courtesie.where(created_at: (Time.now.beginning_of_month)..Time.now.end_of_month)
		@lessons_morning	=	Lesson.where(start_date: (Time.now.beginning_of_month.beginning_of_day)..Time.now.end_of_day, users_enrolled: (1)..10)


	    @num_morning = [] 
	    @lessons_evening = []
        @lessons_morning.each do |te|    
	        if te.start_date <   (te.start_date.beginning_of_day  + 13.hours) 
	        	@num_morning << 1
	        else
	        	@lessons_evening << 1
	        end
        end
        
	end
	def trends
		@users = User.all
		@user_lesson = Schedule.where(user_id: params[:user_id])

		@six_to_eight = []
		@eigth_to_ten = []
		@ten_to_twelve = []
		@twelve_to_fourteen = []
		@fourteen_to_sixteen = []
		@sixteen_to_eighteen = []
		@eighteen_to_twenty = []
		@twenty_to_twentyone	=	[]

		@user_lesson.each do |like|
			case
			when like.start_date < (like.start_date.beginning_of_day + 7.9.hours) 
			  @six_to_eight << 1
			when like.start_date < (like.start_date.beginning_of_day + 9.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 7.9.hours)
			  @eigth_to_ten << 1
			when like.start_date < (like.start_date.beginning_of_day + 11.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 9.9.hours)
			  @ten_to_twelve << 1
			when like.start_date < (like.start_date.beginning_of_day + 13.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 11.9.hours)
			  @twelve_to_fourteen << 1
			when like.start_date < (like.start_date.beginning_of_day + 15.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 13.9.hours)
			  @fourteen_to_sixteen << 1
			when like.start_date < (like.start_date.beginning_of_day + 17.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 12.9.hours)
			  @sixteen_to_eighteen << 1
			when like.start_date < (like.start_date.beginning_of_day + 19.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 11.9.hours)
			  @eighteen_to_twenty << 1
			when like.start_date < (like.start_date.beginning_of_day + 20.9.hours)	&&	like.start_date	>	(like.start_date.beginning_of_day + 10.9.hours)
			  @twenty_to_twentyone << 1
			end
		end
		@pick = []
			@pick << @six_to_eight.count.to_i
			@pick << @eigth_to_ten.count.to_i
			@pick << @ten_to_twelve.count.to_i
			@pick << @twelve_to_fourteen.count.to_i
			@pick << @fourteen_to_sixteen.count.to_i
			@pick << @sixteen_to_eighteen.count.to_i
			@pick << @eighteen_to_twenty.count.to_i
			@pick << @twenty_to_twentyone.count.to_i
		@pick = @pick.sort! {|x, y| y <=> x}

		case @pick.first
		when @six_to_eight.count.to_i
			@mensaje = "6AM - 8AM"
			@mayor_franja = @six_to_eight
		when @eigth_to_ten.count.to_i
			@mensaje = "8AM - 10AM"
			@mayor_franja = @eigth_to_ten
		when @ten_to_twelve.count.to_i
			@mensaje = "10AM - 12PM"
			@mayor_franja = @ten_to_twelve
		when @twelve_to_fourteen.count.to_i
			@mensaje = "12PM - 14PM"
			@mayor_franja = @twelve_to_fourteen
		when @fourteen_to_sixteen.count.to_i
			@mensaje = "14PM - 16PM"
			@mayor_franja = @fourteen_to_sixteen
		when @sixteen_to_eighteen.count.to_i
			@mensaje = "16PM - 18PM"
			@mayor_franja = @sixteen_to_eighteen
		when @eighteen_to_twenty.count.to_i
			@mensaje = "18PM - 20PM"
			@mayor_franja = @eighteen_to_twenty
		when @twenty_to_twentyone.count.to_i
			@mensaje = "20PM - 21PM"
			@mayor_franja = @twenty_to_twentyone
		end



		@total = @user_lesson.count
		x = (@mayor_franja.count.to_f * 100)	/	@total.to_f
		@gusto = x.to_f
	end
end
