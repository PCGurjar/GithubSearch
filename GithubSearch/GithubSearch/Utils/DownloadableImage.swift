//
//  DownloadableImage.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        
        let url = URL(string: urlString)
        if url == nil { return }
        
        self.image = nil
        // check cached image
        if let cachedImage = CacheManager.shared.getImageFromCache(key: urlString) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            // if not, download image from url
            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }

                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        CacheManager.shared.saveImageToCache(key: urlString, image: image)
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
