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

    override func customizeUIComponents() {
                
        chooseDefitionView.removeFromSuperview()
        backButton.frame = CGRect(x: 5, y: 5, width: 100, height: 100)
    }
    
    
    
    override func updateUI(_ isForFullScreen: Bool) {
        super.updateUI(isForFullScreen)
        
    }
    
    
}
