//
//  RepoCell.swift
//  RxSwift-Demo-github-browse
//
//  Created by Sean Yin on 2019/3/5.
//  Copyright © 2019 Sean Yin. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

    @IBOutlet weak private var idLabel:UILabel!
    @IBOutlet weak private var nameLabel:UILabel!
    @IBOutlet weak private var isPrivateLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(data:GitRepo) {
        
        idLabel.text = "Owner: " + data.owner.name
        let isPublic = data.isPrivate ? "Np" : "Yes"
        isPrivateLabel.text = "Public: " + isPublic
        nameLabel.text = "Repo name: " + data.name
    }
}
