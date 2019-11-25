//
//  SearchTableViewCell.swift
//  flairProject
//
//  Created by kenwele mirza on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class ResultSearchTableViewCell: UITableViewCell {
	
	
	@IBOutlet weak var productImageView: UIImageView!
	@IBOutlet weak var nameProductLabel: UILabel!
	@IBOutlet weak var brandLabel: UILabel!
	
	@IBOutlet weak var nutritionGrade: UILabel!
	@IBOutlet weak var nutritionGradeView: UIView!
	@IBOutlet weak var addToFavorites: UIButton!
	@IBOutlet weak var gradeLabel: UILabel!
	
	
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
