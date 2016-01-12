class Task < ActiveRecord::Base
	belongs_to :user
	def time
	    @user = User.find(session[:user])
	    stime = @user.created_at
	    ftime = Time.zone.now
	    sec_diff = (stime-ftime).to_i.abs
	    hours = sec_diff / 3600
	    sec_diff -= hours * 3600
	    mins = sec_diff / 60
	    sec_diff -= mins * 60
	    secs = sec_diff
	    puts "========================="
	    puts
	    printf "%02dh:%02dm:%02ds", hours, mins, secs
	    puts
	    puts "========================="
	    puts stime
	    puts ftime
  	end
end
