//
//  Extensions.swift
//  Game'OChat
//
//  Created by Roushil singla on 2/25/20.
//  Copyright © 2020 personal. All rights reserved.
//

import Foundation
import UIKit
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView{

    func loadImageUsingCache(image: String){
    
        self.image = nil
        
        if let cachedImage = imageCache.object(forKey: image as NSString) as? UIImage{

            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: image) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                
                guard let downloadedImage = UIImage(data: data) else { return }
                imageCache.setObject(downloadedImage, forKey: image as NSString)
                self.image = downloadedImage
            }
        }.resume()
    }
}

