//
//  NewsCell.swift
//  LiveSportsTVHD
//
//  Created by Ali  Raza on 03/06/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {
    @IBOutlet weak var newsBg_imgview: UIImageView!
    @IBOutlet weak var newsTitle_lbl: UILabel!
    @IBOutlet weak var titleView: UIView!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        titleView.layer.cornerRadius = 4
        titleView.clipsToBounds = true
    }
}
