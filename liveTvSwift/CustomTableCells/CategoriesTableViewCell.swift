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
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImageView.layer.cornerRadius = 15
        categoryImageView.clipsToBounds = true
        // Initialization code
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
    }
}
