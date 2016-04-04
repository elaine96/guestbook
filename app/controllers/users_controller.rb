class UsersController < ApplicationController
	def login
		session[:username] = nil
	end


	# Get the user name and password, check whether the user name and password is empty.
	# If not null, verify the user name exists. 
	# If any, verify password is correct.
	# If correct, login, enter the message page.
	def login_handle
		username = params[:username]
		password = params[:password]
		if User.find_by_username(username)
			@user = User.find_by_username(username)
			if @user.password == params[:password]
				session[:username] = @user.username
				redirect_to(:controller => 'messages', :action => 'index')
			else
				@password_error = 'password is wrong'
				render "login"
			end
		else
			@username_error = 'username is wrong'
			render "login"
		end
	end

	def register
	end


	# Access to input the user name, password, confirm password and email, check whether is empty.
	# If not empty, check whether the user name repetition. 
	# Only if the user name, password and confirmation password are consistent.
	# If consistent, check the email format is correct.
	# If correct, check your email has been registered.
	# If has not been registered,registration, jump to the login page.
	def register_handle
		username = params[:username]
		password = params[:password]
		repassword = params[:repassword]
		email = params[:email]
		if username.size < 6 || username.size >12
			@username_error = 'longer than 6 , shorter than 12'
			render "register"
		else
			if User.find_by_username(username)
				@username_error = 'username alredy exists'
				render "register"
			else
				if password.size < 6
					@password_error = 'cannot be shorter than 6'
					render "register"			
				else
					if password != repassword
						@repassword_error = 'passwords are not consistent'
						render "register"
					else
						if /[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}/i =~ email
							if User.find_by_email(email)
								@email_error = 'email has been registered'
								render 'register'
							else
								@user = User.new
								@user.username = username
								@user.password = password
								@user.repassword = repassword
								@user.email = email
								@user.save
								redirect_to '/'
							end
						else
							@email_error = 'email format is wrong'
							render "register"
						end
					end
				end
			end
		end
	end
end
