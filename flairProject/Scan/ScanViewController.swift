//
//  ScanViewController.swift
//  flairProject
//
//  Created by NORA GOUGANE on 25/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit
//Ajout des imports nécessaire à la fonctionnalité Scan
import AVFoundation
import BarcodeScanner
import Alamofire
import SwiftyJSON

// on rajoute les protocoles de la libraire BarcodeScanner
class ScanViewController: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
	
	//Ci-dessous les fonctions inclut dans le protocole de BarcodeScanner
	func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
		controller.reset()
	}
	
	func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
		print("toto \(error)")
	}
	
	func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
		print("On cherche un résultat pour \(code)")
		self.getInfoApi(code: code)
		// Contrôle du temps de load avec un timer - a tester ou à améliorer
		Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: {_ in
			print("on a trouvé / ou pas")
			if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as? ProductDetailsViewController {
				self.show(viewController, sender: nil)
			}
			controller.reset(animated: true)
		})
	}
	
	
	@IBOutlet weak var containerScanView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		loadScanner()
		
		
	}
	
	func loadScanner() {
		//On instancie la class BarcodeScannerViewController
		// cree le child view controller -> l'enfant du containerView
		let scannerVC = BarcodeScannerViewController()
		
		// On dit que la frame de l'objet scannerVC est égale à toute la frame (bounds) du containerView
		scannerVC.view.frame = containerScanView.bounds
		//on lui déclare correctment les delegates pattern nécessaires dans les protocoles
		//         cf doc github
		scannerVC.codeDelegate = self
		scannerVC.errorDelegate = self
		scannerVC.dismissalDelegate = self
		
		//on ajoute à la vue du container la vue de l'enfant
		containerScanView.addSubview(scannerVC.view)
		//On dit au parent quel enfant on lui ajouté
		self.addChild(scannerVC)
		
		//on dit à l'enfant dans quel parent il est utilisé
		scannerVC.didMove(toParent: self)
	}
	
	private func getInfoApi(code: String){
		Alamofire.request("https://world.openfoodfacts.org/api/v0/product/\(code).json")
			.validate(statusCode: 200..<300)
			.validate(contentType: ["application/json"])
			.responseJSON { response in
				print("Request: \(String(describing: response.request))")   // original url request
				print("Response: \(String(describing: response.response))") // http url response
				print("Result: \(response.result)")                         // response serialization result
				
				if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
					print("Data: \(utf8Text)") // original server data as UTF8 string
					do{
						// Get json data
						let json = try JSON(data: data)
						
						
						// Loop sub-json countries array
						Product.current = Product(code: "\(json["code"])", name: "\(json["product"]["product_name"])", brand: "\(json["product"]["brands"])", nutritionGrade: "\(json["product"]["nutrition_grade_fr"])", fats: "\(json["product"]["nutriments"]["fat_100g"])", saturatedFats: "\(json["product"]["nutriments"]["saturated-fat_100g"])", sugars: "\(json["product"]["nutriments"]["carbohydrates_100g"])", salt: "\(json["product"]["nutriments"]["sodium_100g"])", categories: "\(json["product"]["categories"])", ingredientsList: "\(json["product"]["ingredients_text"])", labels: "\(json["product"]["labels"])", keywords: "\(json["product"]["generic_name"])", image: "\(json["product"]["image_front_thumb_url"])", novaGroup: "\(json["product"]["nutriments"]["nova-group_100g"])")
						
					}catch{
						print("Unexpected error: \(error).")
					}
				}
		}
	}
}

/*adz
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// Get the new view controller using segue.destination.
// Pass the selected object to the new view controller.
}
*/


