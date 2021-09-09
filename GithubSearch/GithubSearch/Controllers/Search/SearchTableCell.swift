//
//  SearchTableCell.swift
//  GithubSearch
//
//  Created by Poonamchand on 09/09/21.
//

import UIKit

class SearchTableCell: UITableViewCell {
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgUser: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // this is for search
    var modelUser: Item? {
        didSet {
            if let model = modelUser {
                lblLogin.text = model.login.uppercased()
                lblScore.text = "Score: \(model.score)"
                imgUser.image = UIImage(named: "placeholder")
                imgUser.loadImageUsingCache(withUrl: model.avatarURL)
            }
        }
    }
    
    // this is for search
    var modelFlower: Follower? {
        didSet {
            if let model = modelFlower {
                lblLogin.text = model.login.uppercased()
                lblScore.text = ""
                imgUser.image = UIImage(named: "placeholder")
                imgUser.loadImageUsingCache(withUrl: model.avatarURL)
            }
        }
    }
}
