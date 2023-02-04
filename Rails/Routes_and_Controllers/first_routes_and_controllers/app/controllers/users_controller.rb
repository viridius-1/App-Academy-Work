class UsersController < ApplicationController 

    def index
        render json: User.all 
    end 

    def create
        user = User.new(user_params) 
        render json: user if user.save! 
    end 

    def show 
        user = User.find(params[:id])
        render json: user if user 
    end 

    def update 
        user = User.find(params[:id])
        render json: user if user.update(user_params)
    end 

    def destroy 
        user = User.find(params[:id])
        
        if user.destroy 
            render json: user
        else 
            puts "Can't delete this user!"
        end 
    end 

    private 

    def user_params
        params.require(:user).permit(:name, :email)
    end 

end 
