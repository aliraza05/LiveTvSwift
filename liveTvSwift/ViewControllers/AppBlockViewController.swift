//
//  AppBlockViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 08/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class AppBlockViewController: UIViewController {

    @IBOutlet weak var description_lbl: UILabel!
    
    var message : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        description_lbl.text = message
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

}
