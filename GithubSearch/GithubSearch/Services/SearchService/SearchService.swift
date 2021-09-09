//
//  SearchService.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class SearchService: NSObject {
    
    /// Search API Call using the "Githum url" method, to retrieve user based on search text 
    ///
    /// - Parameters:
    ///   - text: search term
    ///   - completion: completion handler to retrieve result
    func request(_ searchText: String, completion: @escaping (Result<[Item]?>) -> Void) {
        
        guard let request = RequestConfig.searchRequest(searchText).value else {
            return
        }
        
        NetworkManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if model.items.count > 0 {
                        return completion(.Success(model.items))
                    } else {
                        return completion(.Failure(NetworkManager.errorMessage))
                    }
                } else {
                    return completion(.Failure(NetworkManager.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> SearchModel? {
        do {
            let responseModel = try JSONDecoder().decode(SearchModel.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}

