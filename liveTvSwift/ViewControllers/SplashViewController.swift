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
                let showBtn:Bool = (config["value"] != nil)
                download_btn.isHidden = !showBtn
            }
            if key == "Time"
            {
                splashTime = config["value"].floatValue
            }
            
        }
//        self.perform(#selector(hideSplash), with: nil, afterDelay: TimeInterval(splashTime))

        self.perform(#selector(hideSplash), with: nil, afterDelay: 3.0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func downloadAction(_ sender: Any)
    {
        hideSplash()
    }
    
    @objc func hideSplash()
    {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
}
