//
//  FollowerCoordinator.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import Foundation
import UIKit

class FollowerCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    let followerViewModel: FollowerViewModel
    
    init(controller: UINavigationController?, viewModel: FollowerViewModel) {
        navigationController = controller
        followerViewModel = viewModel
    }
    
    func viewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FollowersViewController") as! FollowersViewController
        vc.viewModel = followerViewModel
        return vc
    }
    
    func route() {
        self.navigationController?.pushViewController(viewController(), animated: true)
    }
    
}
