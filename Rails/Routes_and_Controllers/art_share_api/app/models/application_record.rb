class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def get_collection_list(collections)
      art_collections = Hash.new { |hash, key| hash[key] = [] }
      collections.each { |collection_instance| art_collections[collection_instance.name] << collection_instance } 
      art_collections
  end 
end
