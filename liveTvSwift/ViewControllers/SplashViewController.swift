//
//  SplashViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 03/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var description_lbl: UILabel!
    @IBOutlet weak var heading_lbl: UILabel!
    @IBOutlet weak var download_btn: UIButton!
    
    var configuration: JSON = []

    var splashTime:Float = 5.0
    var buttonDownloadLink : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for config in  configuration["application_configurations"].arrayValue
        {
            
            let key = config["key"].stringValue
            
            if key == "Heading"
            {
                heading_lbl.text = config["value"].stringValue
            }
            if key == "DetailText"
            {
                description_lbl.text = config["value"].stringValue
            }
            if key == "ButtonText"
            {
                let title = "    \(config["value"].stringValue)     "
                download_btn.setTitle(title, for: UIControlState.normal)
            }
            if key == "ShowButton"
            {
                let showBtn:Bool = config["value"].boolValue
                download_btn.isHidden = !showBtn
            }
            if key == "ButtonLink"
            {
                buttonDownloadLink = config["value"].stringValue
            }
            if key == "Time"
            {
                splashTime = config["value"].floatValue
            }
            
        }
        self.perform(#selector(hideSplash), with: nil, afterDelay: TimeInterval(splashTime))

//        self.perform(#selector(hideSplash), with: nil, afterDelay: 3.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func downloadAction(_ sender: Any)
    {
        //uncomment for testing
//        buttonDownloadLink = "https://itunes.apple.com/us/app/invite-and-meet-relationship/id1187403952?mt=8"
        let url = URL(string: buttonDownloadLink)

        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        }
    }
    
    @objc func hideSplash()
    {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
