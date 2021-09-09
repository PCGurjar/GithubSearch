//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var lblSearching: UILabel!
    @IBOutlet weak var searchTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var viewModel = SearchViewModel()

    // to handle cancel, search operation
    var workItemReference: DispatchWorkItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        viewModelClosures()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        searchTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK:- Configure UI
extension SearchViewController {
    
    fileprivate func configureUI() {
        // Do any additional setup after loading the view, typically from a nib.
        setSearchBar()
        self.lblSearching.isHidden = true
        searchTable.delegate = self
        searchTable.dataSource = self
    }
    
    // MARK:- Set search bar data
    func setSearchBar() {
        self.searchBar.isUserInteractionEnabled = true
        self.searchBar.delegate = self
    }
}


//MARK:- Clousers
extension SearchViewController {
    
    fileprivate func viewModelClosures() {
        viewModel.dataUpdated = { [weak self] in
            print("data source updated")
            self?.lblSearching.isHidden = true
            
            self?.searchTable.reloadData()
        }
    }
}


// MARK:- search bar delegates
extension SearchViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.searchBar.endEditing(true)
        self.searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // cancel previous task
        workItemReference?.cancel()
        
        let workItem = DispatchWorkItem {
            self.searchImageOnTextChange()
        }
        
        workItemReference = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItemReference!)
    }
    
    
    // This is for searching
    private func searchImageOnTextChange() {
        guard let text = searchBar.text, text.count > 1 else {
            // cancel network manager
            NetworkManager.shared.cancelTask()
            self.lblSearching.isHidden = true
            self.viewModel.removeAllEelement()
            searchTable.reloadData()
            return
        }
        
        searchTable.reloadData()
        self.lblSearching.isHidden = false
        
        viewModel.search(text: text) {
            print("search completed.")
        }
    }

}


//MARK:- UITableViewDataSource
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableCell", for: indexPath) as? SearchTableCell {
            if viewModel.userArray.count > indexPath.row {
                cell.modelUser = viewModel.userArray[indexPath.row]
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.userArray[indexPath.row]
        let viewModel = FollowerViewModel(name: model.login, url: model.followersURL)
        
        let coordinator = FollowerCoordinator(controller: self.navigationController, viewModel: viewModel)
        coordinator.route()
    }
}

