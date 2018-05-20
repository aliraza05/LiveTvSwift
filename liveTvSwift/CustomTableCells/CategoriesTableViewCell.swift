//
//  CategoriesTableViewCell.swift
//  liveTvSwift
//
//  Created by Ali Raza on 03/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var thumbnail_imgV: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        categoryImageView.layer.cornerRadius = 15
        categoryImageView.clipsToBounds = true
        
        thumbnail_imgV.layer.cornerRadius = 0.5 * thumbnail_imgV.bounds.size.width
        thumbnail_imgV.clipsToBounds = true
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadChannel(event: Event)
    {
        name_lbl.text = event.name
        if let url = URL(string: event.image_url)
        {
            categoryImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSmal"))
        }
        if let thumburl = URL(string: event.thumbnail_image)
        {
            categoryImageView.kf.setImage(with: thumburl, completionHandler: {
                (image, error, cacheType, imageUrl) in
                
                self.setNeedsLayout()
            })
            
        }
    }
}
