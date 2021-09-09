//
//  NetworkManager.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    
    static let errorMessage = "Something went wrong, Please try again later"
    static let noInternetConnection = "Please check your Internet connection and try again."
    
    fileprivate var task: URLSessionTask?
    
    //MARK: - Cancel all previous tasks
    func cancelTask(){
        task?.cancel()
    }
    
    func request(_ request: Request, completion: @escaping (Result<Data>) -> Void) {
        
        guard (Reachability.currentReachabilityStatus != .notReachable) else {
            return completion(.Failure(NetworkManager.noInternetConnection))
        }
            
        // cancel previous task in case of search
        self.cancelTask()
        
        let session = URLSession.shared
        task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard error == nil else {
                return completion(.Failure(error!.localizedDescription))
            }
            
            guard let data = data else {
                return completion(.Failure(error?.localizedDescription ?? NetworkManager.errorMessage))
            }
            
            guard let stringResponse = String(data: data, encoding: String.Encoding.utf8) else {
                return completion(.Failure(error?.localizedDescription ?? NetworkManager.errorMessage))
            }
            
            print("Respone: \(stringResponse)")
            return completion(.Success(data))
        }
        task?.resume()
    }
    
}
