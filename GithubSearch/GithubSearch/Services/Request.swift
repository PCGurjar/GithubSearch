//
//  Request.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    
    var value: String {
        return self.rawValue
    }
}

class Request: NSMutableURLRequest {
    
    convenience init?(requestMethod: RequestMethod, urlString: String, bodyParams: [String: Any]? = nil) {
        
        guard let url =  URL.init(string: urlString) else {
            return nil
        }
        
        self.init(url: url)
        
        do {
            if let bodyParams = bodyParams {
                let data = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
                self.httpBody = data
            }
        } catch {
            print("error in JSONSerialization")
        }
        
        self.httpMethod = requestMethod.value
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
