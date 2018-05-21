//
//  MoreViewController.swift
//  liveTvSwift
//
//  Created by Ali  Raza on 06/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class MoreViewController: UIViewController,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var support_btn: UIButton!
    @IBOutlet weak var version_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        support_btn.titleLabel?.minimumScaleFactor = 0.5
        support_btn.titleLabel?.numberOfLines = 0
        support_btn.titleLabel?.adjustsFontSizeToFitWidth = true

        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            let title = "version " + version
            version_btn.setTitle(title, for: UIControlState.normal)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mailAction(_ sender: Any) {
        
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Feedback"
            let messageBody = "Feature request or bug report?"
            let toRecipents = [FEEDBACK_EMAIL]
            let mc: MFMailComposeViewController = MFMailComposeViewController()
            mc.mailComposeDelegate = self
            mc.setSubject(emailTitle)
            mc.setMessageBody(messageBody, isHTML: false)
            mc.setToRecipients(toRecipents)
            self.present(mc, animated: true, completion: nil)
        }else {
            print("Cannot send mail")
            // give feedback to the user
        }
    }
    
    @IBAction func termsAction(_ sender: Any)
    {
        openURL(url: TERMS_URL)
    }
    
    @IBAction func rateusAction(_ sender: Any) {
        openURL(url: TERMS_URL)
    }
    
    @IBAction func versionAction(_ sender: Any) {
    }
    
    @IBAction func supportAction(_ sender: Any)
    {
    }
    @IBAction func moreAppsAction(_ sender: Any)
    {
        openURL(url: TERMS_URL)
    }
    
    // MARK: Helper Method

    func openURL(url : String)
    {
        let url = URL(string: url)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
