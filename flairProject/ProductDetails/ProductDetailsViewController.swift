//
//  ProductDetailsViewController.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 25/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ProductDetailsViewController: UIViewController {
	

	@IBOutlet weak var localisationView: UIView!
	@IBOutlet weak var evaluationView: UIView!
	@IBOutlet weak var recommandationView: UIView!
	@IBOutlet weak var productNameLabel: UILabel!
	@IBOutlet weak var productBrandLabel: UILabel!
	@IBOutlet weak var nutriGradeLabel: UILabel!
	@IBOutlet weak var gradeLabel: UILabel!
	@IBOutlet weak var productImageView: UIImageView!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setDataToOutlet()
		chargeFirstView()
    }
	
	
	@IBAction func categoryViewSegmentedControl(_ sender: UISegmentedControl) {
		changeView(sender: sender)
	}
	
	@IBAction func addFavoriteButton(_ sender: UIButton) {
		if Favorite.all.filter({$0.name == Product.current.name}).count == 0{
			addFavorite(product: Product.current)
		}
		
	}
	
	func chargeFirstView(){
		localisationView.isHidden = true
		evaluationView.isHidden = false
		recommandationView.isHidden = true
	}
	
	func changeView(sender: UISegmentedControl){
		if sender.selectedSegmentIndex == 0{
			localisationView.isHidden = true
			evaluationView.isHidden = false
			recommandationView.isHidden = true
		}else if sender.selectedSegmentIndex == 1{
			localisationView.isHidden = false
			evaluationView.isHidden = true
			recommandationView.isHidden = true
		}else{
			localisationView.isHidden = true
			evaluationView.isHidden = true
			recommandationView.isHidden = false
		}
	}
	
	private func setDataToOutlet(){
		productNameLabel.text = Product.current.name
		productBrandLabel.text = Product.current.brand
		nutriGradeLabel.text = Product.current.nutritionGrade.uppercased()
		switch Product.current.nutritionGrade {
		case "a":
			nutriGradeLabel.backgroundColor = UIColor.green
		case "b":
			nutriGradeLabel.backgroundColor = UIColor.green
		case "c":
			nutriGradeLabel.backgroundColor = UIColor.yellow
		case "d":
			nutriGradeLabel.backgroundColor = UIColor.orange
		case "e":
			nutriGradeLabel.backgroundColor = UIColor.red
		default:
			nutriGradeLabel.isHidden = true
			gradeLabel.isHidden = true
		}
		gradeLabel.text = Product.current.grade
		let url = URL(string: Product.current.image)
		productImageView.kf.setImage(with: url)
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
		favorite.categories = product.categories
		favorite.fats = product.fats
		favorite.ingredientsList = product.ingredientsList
		favorite.labels = product.labels
		favorite.salt = product.salt
		favorite.saturatedFats = product.saturatedFats
		favorite.sugars = product.sugars
		print(favorite)
		
		var found = false
//		if Favorite.all.filter({ $0.name == favorite.name }).count == 0 {
//			try? AppDelegate.viewContext.save()
//		}

			try? AppDelegate.viewContext.save()

	}
}

