//
//  Coordinator.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

public protocol Coordinator {
    
    var navigationController: UINavigationController? {get set}
    
    func viewController() -> UIViewController
    func route()
}
