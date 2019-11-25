//
//  FilterCollectionViewCell.swift
//  flairProject
//
//  Created by NORA GOUGANE on 28/07/2019.
//  Copyright © 2019 NORA GOUGANE. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageCell.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.imageCell.layer.cornerRadius = CGFloat(roundf(Float(self.imageCell.frame.size.width / 2.0)))
    }
    
}
