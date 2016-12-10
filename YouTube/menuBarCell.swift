//
//  menuBarCell.swift
//  YouTube
//
//  Created by Omry Dabush on 07/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class menuBarCell: UICollectionViewCell {

    
    @IBOutlet weak var menuBarImageView: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isHighlighted: Bool{
        didSet{
            menuBarImageView.tintColor = isHighlighted ? UIColor.white : UIColor(colorLiteralRed: 91/255, green: 14/255, blue: 12/255, alpha: 1)
        }
    }
        override var isSelected: Bool{
        didSet{
            menuBarImageView.tintColor = isSelected ? UIColor.white : UIColor(colorLiteralRed: 91/255, green: 14/255, blue: 12/255, alpha: 1)
        }
    }

    
}
