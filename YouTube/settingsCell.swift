//
//  settingsCell.swift
//  YouTube
//
//  Created by Omry Dabush on 12/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell{
    
    var setting: Setting?  {
        didSet{
            settingLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.iconName{
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.darkGray
            }
        }
    }
    
    let iconImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Setting"
        label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(settingLabel)
        addSubview(iconImageView)
    
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0(30)]-8-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : iconImageView , "v1": settingLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : settingLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : iconImageView]))
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
            settingLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
}
