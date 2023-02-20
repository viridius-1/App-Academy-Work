class UsersController < ApplicationController 
    def index
        #get an array of all users, make it available to view
        @users = User.all 
        render :index
    end 
end 