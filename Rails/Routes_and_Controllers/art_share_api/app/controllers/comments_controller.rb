class CommentsController < ApplicationController 
    verify_authenticity_token

    def index 
        if params[:author_id]
            render json: User.find(params[:author_id]).comments 
        elsif params[:artwork_id] 
            render json: Artwork.find(params[:artwork_id]).comments
        else   
            render json: Comment.all
        end 
    end 

    def create 
        comment = Comment.new(comment_params)

        if comment.author_id && comment.artwork_id && comment.body 
            comment.save! 
            render json: comment, status: :created
        else 
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    def destroy 
        comment = Comment.find(params[:id])
        render json: comment if comment.destroy 
    end 

    private 

    def comment_params
        params.require(:comment).permit(:author_id, :artwork_id, :body)
    end 
end 