class ArtworksController < ApplicationController
    self.verify_authenticity_token

    def index 
        render json: Artwork.artworks_for_user_id(params[:user_id])
    end 

    def create 
        artwork = Artwork.new(artwork_params)

        if artwork.title && artwork.image_url && artwork.artist_id
            artwork.save! 
            render json: artwork, status: :created
        else 
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end 

    def show 
        render json: Artwork.find(params[:id]) 
    end 

    def update
        artwork = Artwork.find(params[:id])
        
        if artwork.update(artwork_params)
            render json: artwork
        else 
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    def destroy 
        artwork = Artwork.find(params[:id])
        render json: artwork if artwork.destroy
    end 

    private 

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end 

end 