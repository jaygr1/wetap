class SessionsController < ApplicationController

   def create
     user = User.from_oath(auth_hash)

     if user.save
       flash[:success] = "#{user.name} was successfully found or created!"
       session[:current_user_uuid] = user.uuid
     else
       flash[:error] = "User was not found or created"
     end

     redirect_to root_path
   end

   def destroy
     if current_user
       session.delete(:current_user_uuid)
       current_user = nil
       flash[:success] = 'See you!'
     end
     redirect_to root_path
   end

   protected

   def auth_hash
     HashWithIndifferentAccess.new(request.env['omniauth.auth'])
   end
 end
