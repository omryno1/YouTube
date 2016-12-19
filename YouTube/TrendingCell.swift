//
//  TrendingCell.swift
//  YouTube
//
//  Created by Omry Dabush on 19/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {
    
    override func fetchVideoData() {
        ApiService.sharedInstance.fetchTrendingVideos { (videos) in
            self.videos = videos
            self.videoCollectioView.reloadData()
        }
    }
    
}
