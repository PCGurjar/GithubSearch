//
//  FollowerViewModel.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class FollowerViewModel {
    
    // Read only property
    private(set) var followers = Followers()
    let name: String!
    let followerUrl: String!
    var dataUpdated: (() -> Void)?
    
    init(name: String, url: String) {
        self.name = name
        self.followerUrl = url
    }
    
    func fetch(completion: @escaping () -> Void) {
        followers.removeAll()
        fetchResults(completion: completion)
    }
    
    private func fetchResults(completion: @escaping () -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        FollowerService().request(followerUrl) { (result) in
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch result {
                case .Success(let results):
                    if let result = results {
                        self.followers = result
                        self.dataUpdated?()
                    }
                    completion()
                case .Failure(let message):
                    print(message)
                    completion()
                    
                case .Error(let error):
                    print(error)
                    completion()
                }
            }
        }
    }
    
}
