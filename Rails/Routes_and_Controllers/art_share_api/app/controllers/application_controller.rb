class ApplicationController < ActionController::Base
    def self.verify_authenticity_token
        skip_before_action :verify_authenticity_token
    end 
end

