class CollectionsController < ApplicationController
    verify_authenticity_token

    def index 
        render json: Collection.all 
    end 

    def show 
        render json: Collection.find(params[:id]) 
    end 

    def create 
        collection = Collection.new(collection_params)

        if collection.user_id && collection.artwork_id && collection.name 
            collection.save! 
            render json: collection, status: :created
        else 
            render json: collection.errors.full_messages, status: :unprocessable_entity
        end 
    end 

    private 

    def collection_params 
        params.require(:collection).permit(:user_id, :artwork_id, :name)
    end 
end 