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
        @cat_colors = Cat.get_cat_colors
    end 

    def create 
        @cat = Cat.new(cat_params)

        if @cat.save
            redirect_to cat_url(@cat)
        else 
            redirect_to new_cat_url
        end 
    end 

    def edit 

    end 

    def update 

    end 

    private 

    def cat_params 
        params.require(:cat).permit(:name, :color, :birth_date, :sex, :description)
    end 
end 

