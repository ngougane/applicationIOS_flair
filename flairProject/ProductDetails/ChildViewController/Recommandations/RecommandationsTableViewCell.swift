//
//  RecommandationsTableViewCell.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class RecommandationsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var productNameLabel: UILabel!
	
	@IBOutlet weak var gradeLabel: UILabel!
	
	@IBOutlet weak var brandLabel: UILabel!
	@IBOutlet weak var nutritionGrade: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
