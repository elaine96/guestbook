class CommentsController < ApplicationController


	# Access to the message id.
	def  comment
		@message = Message.find_by_id(params[:message_id])
	end


	# Access to the session username and input the content of the judge whether content is empty.
	# If the content is not empty, create a comment, jump to message page.
	def comment_handle
		username = session[:username]
		content = params[:content]
		@message = Message.find_by_id(params[:message_id])
		if username == @message.username
			flash[:error] =  'cannot comment yourself'
			redirect_to(:controller => 'comments', :action => 'comment')
		else
			if content.size < 10
				flash[:error] =  'content cannot be shorter than 10'
				redirect_to(:controller => 'comments', :action => 'comment')
			else
				@comment = Comment.new
				@comment.username = username
				@comment.content = content
				@comment.message_id = params[:message_id]
				@comment.save
				redirect_to(:controller => 'messages', :action => 'index')
			end
		end
	end


	# Need to delete the comment id, destroyed. 
	# Jump to message page.
	def destroy
		username = session[:username]
		@comment = Comment.find(params[:id])
		if username == @comment.username
			@comment.destroy
			redirect_to(:controller => 'messages', :action => 'index')
		else
			flash[:error] =  'not accessiable'
			redirect_to(:controller => 'messages', :action => 'index')
		end
	end
end
