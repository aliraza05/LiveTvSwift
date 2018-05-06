//
//  MoreViewController.swift
//  liveTvSwift
//
//  Created by Ali  Raza on 06/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class MoreViewController: UIViewController {

    @IBOutlet weak var version_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            version_btn.setTitle(version, for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailAction(_ sender: Any) {
    }
    
    @IBAction func termsAction(_ sender: Any) {
    }
    
    @IBAction func rateusAction(_ sender: Any) {
    }
    
    @IBAction func versionAction(_ sender: Any) {
    }
    
    @IBAction func supportAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
