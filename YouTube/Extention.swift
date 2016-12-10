//
//  Extention.swift
//  YouTube
//
//  Created by Omry Dabush on 10/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImageUsingUrlString(urlString: String){
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if (error != nil){
                print (error as! NSError)
            }
            // Bounce back to the main thread to update the UI
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}

