//
//  EvaluationsViewController.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
import Alamofire

class EvaluationsViewController: UIViewController {
	
	
	@IBOutlet weak var fats: UILabel!
	@IBOutlet weak var saturatedFats: UILabel!
	@IBOutlet weak var sugar: UILabel!
	@IBOutlet weak var indicateurSugar: UIView!
	@IBOutlet weak var indicateurGSature: UIView!
	@IBOutlet weak var indicateursGraisses: UIView!
	@IBOutlet weak var salt: UILabel!
	@IBOutlet weak var indicateurSalt: UIView!
	@IBOutlet weak var categorieProduct: UITextView!
	
	@IBOutlet weak var labels: UITextView!
    @IBOutlet weak var sante: UIView!
    @IBOutlet weak var ecologie: UIView!
    @IBOutlet weak var equitable: UIView!
    
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		getInfoCurrentProduct()
		
	}
	
	func getInfoCurrentProduct(){
		
		fats.text = "\(Product.current.fats)gr pour 100  gr de matières grasses"
		saturatedFats.text = "\(Product.current.saturatedFats)gr pour 100gr de graisses saturés"
        sugar.text = "\(String(describing: Double(Product.current.sugars)))gr pour 100gr de sucre"
		salt.text =  "\(Product.current.salt)gr pour 100gr de sel"
		categorieProduct.text = Product.current.categories
		labels.text = Product.current.labels

		
	}    /*
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	// Get the new view controller using segue.destination.
	// Pass the selected object to the new view controller.
	}
	*/
	
}
