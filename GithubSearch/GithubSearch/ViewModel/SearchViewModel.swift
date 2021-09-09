//
//  SearchViewModel.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class SearchViewModel {
    
    // Read only property
    private(set) var userArray = [Item]()
    private var searchText = ""
    
    var dataUpdated: (() -> Void)?
    
    func search(text: String, completion: @escaping () -> Void) {
        searchText = text
        userArray.removeAll()
        fetchResults(completion: completion)
    }
    
    private func fetchResults(completion: @escaping () -> Void) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        SearchService().request(searchText) { (result) in
            DispatchQueue.main.async {
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch result {
                case .Success(let results):
                    if let result = results {
                        self.userArray = result
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
    
    func removeAllEelement() {
        self.userArray.removeAll()
    }
    
}
