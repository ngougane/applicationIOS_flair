//
//  File.swift
//  flairProject
//
//  Created by Sidi Bouabdallah on 25/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import Foundation

struct Product {
	let code: String
	let name: String
	let brand: String
	var nutritionGrade: String
	//Ajout Nora //
	var fats : String
	var saturatedFats : String
	var sugars : String
	var salt : String
	//let additives : String
	var categories : String
	var ingredientsList : String
	var labels : String
	//Fin ajout Nora /
	var grade: String{
		get{
			switch nutritionGrade {
			case "a":
				return "Excellent"
			case "b":
				return "Bon"
			case "c":
				return "Moyen"
			case "d":
				return "Mauvais"
			default:
				return "Médiocre"
			}
		}
	}
	var color: String{
		get{
			switch nutritionGrade {
			case "a":
				return "green"
			case "b":
				return "green"
			case "c":
				return "yellow"
			case "d":
				return "orange"
			default:
				return "red"
			}
		}
	}
	let keywords: String
	let image: String
	let novaGroup: String
	
	
	static var current = Product(code: "String", name: "String", brand: "String", nutritionGrade: "String", fats: "String", saturatedFats: "String", sugars: "", salt: "", categories: "", ingredientsList: "", labels: "", keywords: "String", image: "", novaGroup: "")
}

