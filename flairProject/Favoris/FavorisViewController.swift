//
//  FavorisViewController.swift
//  flairProject
//
//  Created by Hassen Hadhri on 25/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
import Kingfisher

class FavorisViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
    @IBOutlet weak var favoriteTableView: UITableView!

	
	var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
        favoriteTableView.dataSource = self
		favoriteTableView.delegate = self
        
    }
	
	override func viewWillAppear(_ animated: Bool) {
		favoriteTableView.reloadData()
	}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Favorite.all.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "productFavId", for: indexPath) as? FavoriteTableViewCell {
			
			let favorites = Favorite.all[indexPath.row]
			
			let url = URL(string: favorites.image ?? "")
			cell.imgFavOutlet.kf.setImage(with: url)
            cell.titleFavOutlet.text = favorites.name
			cell.nutriGradeLabel.text = favorites.nutritionGrade?.uppercased()
			
			switch favorites.color{
			case "red":
				cell.nutriGradeLabel.backgroundColor = UIColor.red
			case "yellow":
				cell.nutriGradeLabel.backgroundColor = UIColor.yellow
			case "orange":
				cell.nutriGradeLabel.backgroundColor = UIColor.orange
			case "green":
				cell.nutriGradeLabel.backgroundColor = UIColor.green
			default:
				break
			}
			
			cell.gradeLabel.text = favorites.grade
			cell.brandLabel.text = favorites.brand
			
            return cell
        } else {
          return UITableViewCell()
        }
		
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let f = Favorite.all[indexPath.row]
		Product.current = Product(code: f.code!, name: f.name!, brand: f.brand!, nutritionGrade: f.nutritionGrade!, fats: f.fats!, saturatedFats: f.saturatedFats!, sugars: f.sugars!, salt: f.salt!, categories: f.categories!, ingredientsList: f.ingredientsList!, labels: f.labels!, keywords: f.keywords!, image: f.image!, novaGroup: f.novaGroup!)
		print(f)
	}
	
//	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//		if editingStyle == .delete{
//			Favorite.all.remove(at: indexPath.row)
//			tableView.deleteRows(at: [indexPath], with: .bottom)
//		}
//	}
}
