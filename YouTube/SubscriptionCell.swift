//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Omry Dabush on 19/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    
    override func fetchVideoData() {
        ApiService.sharedInstance.fetchSubscriptionVideos { (videos) in
            self.videos = videos
            self.videoCollectioView.reloadData()
        }
    }
}
