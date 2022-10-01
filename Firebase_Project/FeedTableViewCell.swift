//
//  FeedTableViewCell.swift
//  Firebase_Project
//
//  Created by Fazlı Koç on 1.10.2022.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
