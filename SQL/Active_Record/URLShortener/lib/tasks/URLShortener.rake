namespace :URLShortener do 
    desc "Deletes shortened urls not visited in last minute. Deletes associated Visit & Tagging records."
    task prune: :environment do  
        ShortenedUrl.prune(1)
    end 
end 



