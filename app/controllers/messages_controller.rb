class MessagesController < ApplicationController
	def message
		@message = Message.find_by_id(params[:message_id])
	end


	# Access to the session username, enter the title and content.
	# If a user is null, would not have permission to leave a message.
	# To test whether the title and content is empty, if not empty, add a message. 
	def message_handle
		username = session[:username]
		title = params[:title]
		content = params[:content]
		if username == ''
			render :text => 'not accessiable'
		else
			if title.size < 6
				flash[:error] =  'title cannot be shorter than 6'
				redirect_to(:controller => 'messages', :action => 'index')
			else
				if content.size < 10
					flash[:error] =  'content cannot be shorter than 10'
					redirect_to(:controller => 'messages', :action => 'index')
				else 
					@message = Message.new
					@message.username = username
					@message.title = title
					@message.content = content
					@message.save
					redirect_to(:controller => 'messages', :action => 'index')
				end
			end
		end
	end


	# All information in the data table to get the message.
	def index
		@messages = Message.all
	end


	# Need to delete the message id, destroyed. 
	# Jump to message page.
	def destroy
		@message = Message.find(params[:id])
		username = session[:username]
		if username == @message.username			
			@message.destroy
			redirect_to(:controller => 'messages', :action => 'index')
		else
			flash[:error] =  'not accessiable'
			redirect_to(:controller => 'messages', :action => 'index')
		end
	end
end
