//
//  LocalisationViewController.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class LocalisationViewController: UIViewController, UITableViewDataSource {

	@IBOutlet weak var productLocationTableView: UITableView!
	
	var markets = [Market]()
	// productLocationTableView
	override func viewDidLoad() {
        super.viewDidLoad()
		
		productLocationTableView.dataSource = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		//let element = markets[indexPath.row]
		if let cell = tableView.dequeueReusableCell(withIdentifier: "marketLocationCell", for: indexPath) as? LocalisationTableViewCell {
			cell.marketNameLabel.text = "Carrefour"
			cell.marketDistanceLabel.text = "150 mètres"
			cell.marketPictureImageView.image = UIImage(named: "logo-carrefour")
			tableView.rowHeight = 100
			return cell
		}else{
			return UITableViewCell()
		}
	}

}
