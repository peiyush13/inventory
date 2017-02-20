class AdminsController < ApplicationController

	before_action :authenticate_admin!
  

	def login
		
	end

	def login_check
		if 	admin_signed_in?
			session[:user]=@current_admin[:email]
			redirect_to({:controller =>'summary',:action => 'info'})
  		else
  		 	render('login')
  		end
	end

	def signup

	end

	def signup_check

		p=params[:admin]

		admin=Admin.new({:name=> p[:name],:password =>p[:password],:email =>p[:email],:role =>p[:role]})
		if admin.save
			redirect_to(:action=>'login')	
		else
			redirect_to(:action=>'signup')	
		end	
	
	end
	
	def logout
		session.delete(:message)
		redirect_to(:action=>'login')
	end 		
end
