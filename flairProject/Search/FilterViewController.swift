//
//  FilterViewController.swift
//  flairProject
//
//  Created by NORA GOUGANE on 26/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegate {
    
  let filter = ["Santé","Ecologie", "Equitable", "Viande","Poissons","Légumes", "Fruits", "Boissons" ,  "Sucré", "Salé", "Frais", "Lait", "Fromage", "Pain", "Sauces","Oeufs", "Halal", "Vegan"  ]
    var filterSelected = [String]()
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterCollectionView.dataSource = self
        filterCollectionView.delegate = self

        //        let layout = self.filterCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
//        layout.minimumInteritemSpacing = 5
//        layout.itemSize = CGSize(width: (self.filterCollectionView.frame.size.width)/5, height: (self.filterCollectionView.frame.size.height)/5)
    }
    
    @IBAction func valideFilter(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filter.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = filterCollectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as? FilterCollectionViewCell {
            cell.labelCell.text = filter[indexPath.item]
            cell.imageCell.image = UIImage(named: "\(filter[indexPath.item])")
            cell.layer.borderColor = UIColor.lightGray.cgColor
            cell.layer.borderWidth = 0.5
//            cell.imageCell.layer.backgroundColor = UIColor.red.cgColor
            return cell
        }else{
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell{
            if let filterRequire = cell.labelCell.text {
                if filterSelected.contains("\(filterRequire)"){
                    cell.layer.borderColor = UIColor.lightGray.cgColor
                    cell.layer.borderWidth = 0.5
                    cell.layer.backgroundColor = UIColor.white.cgColor
                    if let indexFilter = filterSelected.firstIndex(of: filterRequire) {
                        print("\(indexFilter)")
                        filterSelected.remove(at: indexFilter)
                        print(filterSelected)
                        
                    }
                }else{
                    print(filterSelected)
                    cell.layer.borderColor = UIColor.green.cgColor
                    cell.layer.borderWidth = 2
                    cell.layer.backgroundColor = UIColor.green.cgColor
                    filterSelected.append(cell.labelCell.text ?? "")
                    print(filterSelected)
                }
            }
        }
    }
    }

