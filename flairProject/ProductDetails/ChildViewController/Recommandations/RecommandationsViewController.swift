//
//  RecommandationsViewController.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class RecommandationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var currentProductsArray = [Product]()
	var keyword = Product.current.keywords
	var searchText = ""
	var urlString: String {
		get{
			return	searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
		}
	}
	
	@IBOutlet weak var recommandationTableView: UITableView!
	var recommandations = [Product]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(searchText)
		recommandationTableView.dataSource = self
		recommandationTableView.delegate = self
		
	}
	override func viewWillAppear(_ animated: Bool) {
		print(Product.current.name)
		print(urlString)
		getInfoApi()
	}
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return currentProductsArray.count
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "productRecommandationCell", for: indexPath) as? RecommandationsTableViewCell {
			
			let url = URL(string: currentProductsArray[indexPath.row].image)
			cell.productImageView.kf.setImage(with: url)
			//			cell.productNameLabel.text = element.name
			cell.productNameLabel.text = currentProductsArray[indexPath.row].name
			//			switch element.test{
			//			case .Excellent:
			//				cell.badgeView.backgroundColor = UIColor.green
			//			case .Moyen:
			//				cell.badgeView.backgroundColor = UIColor.orange
			//			case .Mauvais:
			//				cell.badgeView.backgroundColor = UIColor.red
			//			}
			//			cell.productScoreLabel.text = "\(element.mark) / 100"
			cell.nutritionGrade.text =
				currentProductsArray[indexPath.row].nutritionGrade.uppercased()
			switch currentProductsArray[indexPath.row].nutritionGrade {
			case "a":
				cell.nutritionGrade.backgroundColor = UIColor.green
			case "b":
				cell.nutritionGrade.backgroundColor = UIColor.green
			case "c":
				cell.nutritionGrade.backgroundColor = UIColor.blue
			case "d":
				cell.nutritionGrade.backgroundColor = UIColor.orange
			case "e":
				cell.nutritionGrade.backgroundColor = UIColor.red
			default:
				cell.nutritionGrade.backgroundColor = UIColor.gray
				cell.nutritionGrade.text = "?"
			}
			
			cell.brandLabel.text = currentProductsArray[indexPath.row].brand
			//			cell.productStatusLabel.text = "\(element.test)"
			cell.gradeLabel.text = "NOVA : \(currentProductsArray[indexPath.row].novaGroup)"
			tableView.rowHeight = 130
			return cell
		}else{
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		Product.current = currentProductsArray[indexPath.row]
	}
	
	func getInfoApi(){
		
		let searchTextArr = keyword.components(separatedBy: " ")
		searchText = searchTextArr[0]
		print(searchText)
		Alamofire.request("https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(searchText)&search_simple=1&action=process&json=1")
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				
				if let data = response.data, let _ = String(data: data, encoding: .utf8) {
					// original server data as UTF8 string
					do{
						// Get json data
						let json = try JSON(data: data)
						
						for product in json["products"].arrayValue
						{
							if product["nutrition_grade_fr"] == "a" || product["nutrition_grade_fr"] == "b"{
								let product = Product(code: "\(product["code"])", name: "\(product["product_name"])", brand: "\(product["brands"])", nutritionGrade: "\(product["nutrition_grade_fr"])", fats: "\(product["nutriments"]["fat_100g"])", saturatedFats: "\(product["nutriments"]["saturated-fat_100g"])", sugars: "\(product["nutriments"]["carbohydrates_100g"])", salt: "\(product["nutriments"]["sodium_100g"])", categories: "\(product["categories"])", ingredientsList: "\(product["ingredients_text"])", labels: "\(product["labels"])", keywords: "\(product["generic_name"])", image: "\(product["image_front_thumb_url"])", novaGroup: "\(product["nutriments"]["nova-group_100g"])")
								
								self.currentProductsArray.append(product)
							}
							print("TEST : \(self.currentProductsArray)")
							
							//							print(product["generic_name"])
							//							print(product["categories"])
						}
						self.recommandationTableView.reloadData()
						
						
					}catch{
						print("Unexpected error: \(error).")
					}
				}
		}
		
	}
}
