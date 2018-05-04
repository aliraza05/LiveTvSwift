//
//  ChannelTableViewCell.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var channel_img: UIImageView!
    @IBOutlet weak var name_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        channel_img.layer.cornerRadius = 15
        channel_img.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadChannel(channel: Channel)
    {
        name_lbl.text = channel.name
        
    }
}
