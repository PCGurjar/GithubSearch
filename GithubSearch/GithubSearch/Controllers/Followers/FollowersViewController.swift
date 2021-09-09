//
//  FollowersViewController.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class FollowersViewController: UIViewController {
    
    @IBOutlet weak var followerTable: UITableView!
    @IBOutlet weak var lblNoFolower: UILabel!
    
    var viewModel: FollowerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
        
        viewModel?.fetch {
            print("Fetch complete")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = viewModel?.name.uppercased()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        followerTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- Configure UI
extension FollowersViewController {
    
    fileprivate func configureUI() {
        // Do any additional setup after loading the view, typically from a nib.
        followerTable.delegate = self
        followerTable.dataSource = self
    }
}

//MARK:- Clousers
extension FollowersViewController {
    
    fileprivate func viewModelClosures() {
        viewModel?.dataUpdated = { [weak self] in
            if self?.viewModel?.followers.count ?? 0 == 0 {
                self?.lblNoFolower.isHidden = false
            } else {
                self?.lblNoFolower.isHidden = true
            }
            print("data source updated")
            self?.followerTable.reloadData()
        }
    }
}


//MARK:- UITableViewDataSource
extension FollowersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.followers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as? SearchTableCell {
            cell.modelFlower = viewModel?.followers[indexPath.row]
            return cell
        }else{
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel?.followers[indexPath.row]
        guard let name = model?.login else{
            return
        }
        guard let url = model?.followersURL else{
            return
        }
        let viewModel = FollowerViewModel(name: name, url: url)
        let coordinator = FollowerCoordinator(controller: self.navigationController, viewModel: viewModel)
        coordinator.route()
    }
}

