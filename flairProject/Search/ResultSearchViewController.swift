//
//  ResultSearchViewController.swift
//  flairProject
//
//  Created by kenwele mirza on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON

class ResultSearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
	
	var searchText = ""
	var urlString: String {
		get{
			return	searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
		}
	}
	var products = [Product]()
	var currentProductsArray = [Product]()
	
	@IBOutlet weak var searchResultTableView: UITableView!
	@IBOutlet weak var searchBarOutlet: UISearchBar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		// On déclare où le table va chercher les données
		//Pour l'instant on charge les données via un tableau de données en dur
		searchResultTableView.dataSource = self
		if #available(iOS 11.0, *) {
			self.navigationController?.navigationBar.prefersLargeTitles = true
		} else {
			// Fallback on earlier versions
		}
		
		// fillData()
		setUpSearchBar()
		// Do any additional setup after loading the view.
	}
	
	
	@IBAction func AddToFavorite(_ sender: UIButton) {
		//addFavorite(product: <#T##Product#>)
	}
	
	private func addFavorite(product: Product) {
		let favorite = Favorite(context: AppDelegate.viewContext)
		favorite.code = product.code
		favorite.name = product.name
		favorite.brand = product.brand
		favorite.nutritionGrade = product.nutritionGrade
		favorite.image = product.image
		favorite.novaGroup = product.novaGroup
		favorite.grade = product.grade
		favorite.color = product.color
		
		print(favorite)
		
		var found = false
		//		if Favorite.all.filter({ $0.name == favorite.name }).count == 0 {
		//			try? AppDelegate.viewContext.save()
		//		}
		for element in Favorite.all {
			if element.name ==  favorite.name{
				found = true
				break
			}else{
				found = false
			}
		}
		if found == false {
			try? AppDelegate.viewContext.save()
		}
	}
	
	
	func setUpSearchBar() {
		searchBarOutlet.delegate = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// On retourne un entier qui définit le nombre de ligne qu'on veut
		// on a donc en retour la taille du tableau
		return currentProductsArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// On retourne la cell qu'on a désigné
		if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for : indexPath) as? ResultSearchTableViewCell  {
			
			cell.nameProductLabel.text = currentProductsArray[indexPath.row].name
			let url = URL(string: currentProductsArray[indexPath.row].image)
			cell.productImageView.kf.setImage(with: url)
			cell.brandLabel.text = currentProductsArray[indexPath.row].brand
			cell.nutritionGrade.text = currentProductsArray[indexPath.row].nutritionGrade.uppercased()
			cell.gradeLabel.text = "NOVA : \(currentProductsArray[indexPath.row].novaGroup)"
			cell.nutritionGradeView.layer.cornerRadius = 4
			cell.nutritionGradeView.backgroundColor = UIColor.green
			switch currentProductsArray[indexPath.row].nutritionGrade {
			case "a":
				cell.nutritionGradeView.backgroundColor = UIColor.green
			case "b":
				cell.nutritionGradeView.backgroundColor = UIColor.green
			case "c":
				cell.nutritionGradeView.backgroundColor = UIColor.blue
			case "d":
				cell.nutritionGradeView.backgroundColor = UIColor.orange
			case "e":
				cell.nutritionGradeView.backgroundColor = UIColor.red
			default:
				cell.nutritionGradeView.backgroundColor = UIColor.gray
				cell.nutritionGrade.text = "?"
			}
			
			
			return cell
			
		}else{
			return UITableViewCell()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		Product.current = currentProductsArray[indexPath.row]
	}
	
	
	
	// Search Bar
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		guard !searchText.isEmpty else {
			self.searchText = ""
			currentProductsArray = products
			searchResultTableView.reloadData()
			return }
		self.searchText = searchText
		searchResultTableView.reloadData()
	}
	
	
	func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
		
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchBarOutlet.endEditing(true)
		getInfoApi(searchTextt: urlString)
		searchResultTableView.reloadData()
	}
	/*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	func getInfoApi(searchTextt: String){
		Alamofire.request("https://world.openfoodfacts.org/cgi/search.pl?search_terms=\(searchTextt)&search_simple=1&action=process&json=1")
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
							let product = Product(code: "\(product["code"])", name: "\(product["product_name"])", brand: "\(product["brands"])", nutritionGrade: "\(product["nutrition_grade_fr"])", fats: "\(product["nutriments"]["fat_100g"])", saturatedFats: "\(product["nutriments"]["saturated-fat_100g"])", sugars: "\(product["nutriments"]["carbohydrates_100g"])", salt: "\(product["nutriments"]["sodium_100g"])", categories: "\(product["categories"])", ingredientsList: "\(product["ingredients_text"])", labels: "\(product["labels"])", keywords: "\(product["generic_name"])", image: "\(product["image_front_thumb_url"])", novaGroup: "\(product["nutriments"]["nova-group_100g"])")
							
							self.currentProductsArray.append(product)
						}
						self.searchResultTableView.reloadData()
						
						
					}catch{
						print("Unexpected error: \(error).")
					}
				}
		}
	}
	
}
