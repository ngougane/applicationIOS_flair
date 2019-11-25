//
//  LocalisationTableViewCell.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class LocalisationTableViewCell: UITableViewCell {

	@IBOutlet weak var marketPictureImageView: UIImageView!
	@IBOutlet weak var marketNameLabel: UILabel!
	@IBOutlet weak var marketDistanceLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
