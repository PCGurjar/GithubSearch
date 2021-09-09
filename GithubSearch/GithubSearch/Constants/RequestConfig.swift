//
//  RequestConfig.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

enum RequestConfig {
    
    case searchRequest(String)
    case followerRequest(String)
    
    var value: Request? {
        switch self {
            
        case .searchRequest(let searchText):
            let urlString = APIConstants.searchURL + searchText
            let reqConfig = Request.init(requestMethod: .get, urlString: urlString)
            return reqConfig
            
        case .followerRequest(let followerUrl):
            let reqConfig = Request.init(requestMethod: .get, urlString: followerUrl)
            return reqConfig
        }
    }
}


