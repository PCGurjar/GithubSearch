//
//  CacheManager.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import Foundation
import UIKit

class CacheManager: NSObject {

    static let shared = CacheManager()
    
    // Readonly property
    private(set) var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func getImageFromCache(key: String) -> UIImage? {
        if (self.cache.object(forKey: key as AnyObject) != nil) {
            return self.cache.object(forKey: key as AnyObject) as? UIImage
        } else {
            return nil
        }
    }
    
    func saveImageToCache(key: String, image: UIImage) {
        self.cache.setObject(image, forKey: key as AnyObject)
    }
    
}
