//
//  FavoriteTableViewCell.swift
//  flairProject
//
//  Created by Hassen Hadhri on 25/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgFavOutlet: UIImageView!
    @IBOutlet weak var titleFavOutlet: UILabel!
	@IBOutlet weak var nutriGradeLabel: UILabel!
	@IBOutlet weak var gradeLabel: UILabel!
	@IBOutlet weak var brandLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
