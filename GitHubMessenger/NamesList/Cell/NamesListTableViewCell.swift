//
//  NamesListTableViewCell.swift
//  GitHubMessenger
//
//  Created by Gabriel Targon on 12/03/20.
//  Copyright © 2020 Gabriel Targon. All rights reserved.
//

import UIKit

class NamesListTableViewCell: UITableViewCell {

    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
