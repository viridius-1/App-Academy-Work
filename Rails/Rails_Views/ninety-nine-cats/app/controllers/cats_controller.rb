class CatsController < ApplicationController

    def index 
        @cats = Cat.all 
        render :index 
    end 

    def show 
        @cat = Cat.find_by(id: params[:id])

        if @cat  
            render :show 
        else   
            redirect_to cats_url 
        end 
    end 

    def new 

    end 

    def create 

    end 

    def edit 

    end 

    def update 

    end 

    private 

    def cat_params 

    end 
end 

