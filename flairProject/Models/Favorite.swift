//
//  Product.swift
//  flairProject
//
//  Created by Hassen Hadhri on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import Foundation
import CoreData

class Favorite : NSManagedObject{
	
	static var all: [Favorite] {
		let request: NSFetchRequest<Favorite> = Favorite.fetchRequest()
		guard let favorites = try? AppDelegate.viewContext.fetch(request) else { return [] }
		return favorites
	}
//	var code = String()
//    var name = String()
//    var brand = String()
//	var nutritionGrade = String()
//	var grade: String{
//		get{
//			switch nutritionGrade {
//			case "a":
//				return "Excellent"
//			case "b":
//				return "Bon"
//			case "c":
//				return "Moyen"
//			case "d":
//				return "Mauvais"
//			default:
//				return "Médiocre"
//			}
//		}
//	}
//    var image = String()
//	var novaGroup = String()
//
//	super.init(code: String, name: String, brand: String, nutritionGrade: String, image: String, novaGroup: String){
//		self.code = code
//		self.name = name
//		self.brand = brand
//		self.nutritionGrade = nutritionGrade
//		self.image = image
//		self.novaGroup = novaGroup
//	}
	
}

