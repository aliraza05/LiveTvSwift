//
//  EventTableViewCell.swift
//  liveTvSwift
//
//  Created by Ali Raza on 03/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var status_lbl: UILabel!
    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        
        iconView.layer.cornerRadius = 20
        iconView.clipsToBounds = true
        
        iconImageView.layer.cornerRadius = 30
        iconImageView.clipsToBounds = true
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadEvent(event: Event)
    {
        name_lbl.text = event.name
        
        status_lbl.text = event.status
        
        if let url = URL(string: event.image_url)
        {
            iconImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "ball"))
        }
    }
    
}
