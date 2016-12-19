//
//  ApiService.swift
//  YouTube
//
//  Created by Omry Dabush on 15/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
        
    func fetchHomeVideos (Complition: @escaping ([Video])->()){
        fetchVideosWithUrl(urlString: "\(baseUrl)/home.json", Complition: Complition)
    }
    
    func fetchTrendingVideos (Complition: @escaping ([Video])->()){
        fetchVideosWithUrl(urlString: "\(baseUrl)/trending.json", Complition: Complition)

    }
    
    func fetchSubscriptionVideos (Complition: @escaping ([Video])->()){
        fetchVideosWithUrl(urlString: "\(baseUrl)/subscriptions.json", Complition: Complition)
    }
    
    func fetchVideosWithUrl (urlString : String , Complition: @escaping ([Video]) -> ()){
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if (error != nil){
                print (error as! NSError)
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var videos = [Video]()
                //                print(json)
                for dictionary in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.videoTitle = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numOfViews = dictionary["number_of_views"] as? NSNumber
                    video.duration = dictionary["duration"] as? NSNumber
                    
                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    
                    let channel = Channel()
                    channel.channelName = channelDictionary["name"] as? String
                    channel.channelProfileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                    
                }
                DispatchQueue.main.async {
                    Complition(videos)
                }
                
            }catch let jsonError {
                print (jsonError)
            }
            }.resume()
    }
}
