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
    
    var configuration: [[String:String]] = [[ : ]]

    var splashTime:Float = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for config in  configuration
        {
            
            let key = config["key"]

            if key == "Heading"
            {
                heading_lbl.text = config["value"]
            }
            if key == "DetailText"
            {
                description_lbl.text = config["value"]
            }
            if key == "ButtonText"
            {
                let title = "   " + config["value"]! + "   "
                download_btn.setTitle(title, for: UIControlState.normal)
            }
            if key == "ShowButton"
            {
                let showBtn:Bool = (config["value"] != nil)
                download_btn.isHidden = !showBtn
            }
            if key == "Time"
            {
                splashTime = (config["value"]! as NSString).floatValue
            }
            
        }
        
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
    @IBAction func downloadAction(_ sender: Any) {
    }
    
}
