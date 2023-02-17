class UsersController < ApplicationController
    verify_authenticity_token

    def index
        if params[:username]
            render json: User.where(username: params[:username])
        elsif query_in_request_params? 
            name = get_name_from_query
            user = User.select(:id, :username, :created_at, :updated_at).where(username: name)
            if user != []
                render json: user 
            else   
                render plain: "User not in database."
            end 
        else 
            render json: User.all
        end 
    end 

    def create
        user = User.new(user_params) 
        
        if user.username
            user.save! 
            render json: user, status: :created
        else 
            render json: user.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    def show 
        render json: User.find(params[:id]) 
    end 

    def update 
        user = User.find(params[:id])
        
        if user.update(user_params)
            render json: user 
        else 
            render json: user.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    def destroy 
        user = User.find(params[:id])
        render json: user if user.destroy 
    end 

    private 

    def user_params
        params.require(:user).permit(:username)
    end 

    def query_in_request_params?
        params.each { |key, value| return true if !["controller", "action", "username"].include?(key) } 
        false 
    end 

    def get_name_from_query
        params.each { |key, value| return key if key != "username" } 
    end 
end 