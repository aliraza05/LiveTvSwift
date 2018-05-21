//
//  BMPlayerCustomControlView.swift
//  BMPlayer
//
//  Created by BrikerMan on 2017/4/4.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import BMPlayer

class BMPlayerCustomControlView: BMPlayerControlView {
    
    
    /**
     Override if need to customize UI components
     */

    override func customizeUIComponents()
    {
        chooseDefitionView.removeFromSuperview()
        backButton.snp.updateConstraints { (make) in
            make.width.equalTo(200)
        }
        backButton.imageEdgeInsets = UIEdgeInsetsMake(5.0, 20.0, 0.0, 0.0)
        backButton.contentHorizontalAlignment = .left
        
        titleLabel.snp.updateConstraints { (make) in
            make.left.equalTo(backButton.snp.right).offset(-150)
        }
    }
    
    override func updateUI(_ isForFullScreen: Bool)
    {
        super.updateUI(isForFullScreen)
    }
}
