//
//  Extention.swift
//  YouTube
//
//  Created by Omry Dabush on 10/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

let imageCache = NSCache< NSString , UIImage>()

class CustomeImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String){
        
        self.image = nil
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString){
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if (error != nil){
                print (error as! NSError)
            }
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
        }).resume()
    }
}


class BaseCell: UICollectionViewCell{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews(){
        
    }
}
