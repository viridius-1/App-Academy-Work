class BooksController < ApplicationController
    def index 
        @books = Book.all
        render :index
    end 

    def show 
        @book = Book.find_by(id: params[:id])
        
        if @book 
            render :show
        else 
            #return user to index page
            redirect_to books_url
        end 
    end 
end 

