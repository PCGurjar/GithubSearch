//
//  FollowerService.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import Foundation


class FollowerService: NSObject {
    
    /// Follower API Call using the "Github follower url" method, to retrieve user
    ///
    /// - Parameters:
    ///   - text: follower URL 
    ///   - completion: completion handler to retrieve result
    func request(_ url: String, completion: @escaping (Result<Followers?>) -> Void) {
        guard let request = RequestConfig.followerRequest(url).value else {
            return
        }
        
        NetworkManager.shared.request(request) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if model.count > 0 {
                        return completion(.Success(model))
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
    
    func processResponse(_ data: Data) -> Followers? {
        do {
            let responseModel = try JSONDecoder().decode(Followers.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}

