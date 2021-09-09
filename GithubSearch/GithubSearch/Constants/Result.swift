//
//  Result.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

enum Result <T> {
    
    case Success(T)
    case Failure(String)
    case Error(String)
}
