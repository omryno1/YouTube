//
//  VideoCollectionViewCell.swift
//  YouTube
//
//  Created by Omry Dabush on 06/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var titleConstraint: NSLayoutConstraint!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var seperator: UIView!
    
    
    var video : Video?{
        didSet{
            setupThumbnail()
            setupProfile()
            setupSubtitle()
            setupTitle()

        }
    }
    
    func setupThumbnail() {
        if let thumbnailImage = video?.thumbnailImageName {
            self.thumbnail.loadImageUsingUrlString(urlString: thumbnailImage)
        }
    }
    func setupProfile() {
        if let profileImage = video?.channel?.channelProfileImageName {
            self.profile.loadImageUsingUrlString(urlString: profileImage)
        }
    }
    
    func setupSubtitle(){
        //Conevting the number of views to a Decimal formar
        let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
        
        if let channelName = video?.channel?.channelName,let numberOfViews = video?.numOfViews {
            self.subtitle.text = "\(channelName) • \(numberFormatter.string(from: numberOfViews)!) • 2 Years Ago"
        }
    }
    
    func setupTitle(){
        self.title.text = video?.videoTitle
        let titleSize = self.title.sizeThatFits(self.title.layer.bounds.size)
        if (titleSize.height >= 35){
            self.titleConstraint.constant = 44
            self.title.adjustsFontSizeToFitWidth = true
        }else{
            self.titleConstraint.constant = 20
        }
    }
}

