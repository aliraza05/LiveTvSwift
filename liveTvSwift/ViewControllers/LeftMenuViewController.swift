//
//  LeftMenuViewController.swift
//  LiveSportsTVHD
//
//  Created by Ali  Raza on 02/06/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit
import SafariServices
import MessageUI

class LeftMenuViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableview_menu: UITableView!
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var eventController : UINavigationController? = nil
    var catgController : UINavigationController? = nil
    var newsController : UINavigationController? = nil

    var tableDataArray: [[String:String]] = []

    var menu1 = [ "title": "Event", "image": "file_blue",]
    var menu2 = [ "title": "Category", "image": "television",]
    var menu3 = [ "title": "News", "image": "file_blue",]
    var menu4 = [ "title": "Mail / Contact Us", "image": "mail",]
    var menu5 = [ "title": "Rate US", "image": "rate",]
    var menu6 = [ "title": "More Apps", "image": "moreApps",]

    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableDataArray.append(menu1)
        tableDataArray.append(menu2)
        tableDataArray.append(menu3)
        tableDataArray.append(menu4)
        tableDataArray.append(menu5)
        tableDataArray.append(menu6)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 75
        }
        else
        {
            // Iphone
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: LeftMenuCell = tableView.dequeueReusableCell(withIdentifier: "leftmenucell") as! LeftMenuCell
        
        let menuItem = tableDataArray[indexPath.row]
        
        cell.menu_title.text = menuItem["title"]
        cell.menu_imgview?.image = UIImage(named: menuItem["image"]!)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0
        {
            if eventController != nil
            {
                _ = panel!.center(eventController!)
            }else
            {
                eventController = mainStoryboard.instantiateViewController(withIdentifier: "eventScreen") as? UINavigationController
                _ = panel!.center(eventController!)
            }
        }else if indexPath.row == 1
        {
            if catgController != nil
            {
                _ = panel!.center(catgController!)
            }else
            {
                catgController = mainStoryboard.instantiateViewController(withIdentifier: "catScreen") as? UINavigationController
                _ = panel!.center(catgController!)
            }
        }else if indexPath.row == 2
        {
            if newsController != nil
            {
                _ = panel!.center(newsController!)
            }else
            {
                newsController = mainStoryboard.instantiateViewController(withIdentifier: "newsScreen") as? UINavigationController
                _ = panel!.center(newsController!)
            }
        }
        else if indexPath.row == 3
        {
            mailAction()
        }
        else if indexPath.row == 4
        {
            openURL(url: RATE_US_URL)
        }
        else if indexPath.row == 5
        {
            AdsManager.sharedInstance.showInterstatial(nil, location: "more_apps")
        }


        
    }
    
    func openURL(url : String)
    {
        let url = URL(string: url)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    func mailAction()
    {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Live Sports TV"
            let messageBody = ""
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
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
