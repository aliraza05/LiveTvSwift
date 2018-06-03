//
//  FirstViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 26/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit
import MessageUI


class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,MFMailComposeViewControllerDelegate {

    @IBOutlet weak var tableViewEvent: UITableView!
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var tableViewEventHeightConstraint: NSLayoutConstraint!
    var tableDataArray : [Event] = []
    var isFirstTime : Bool = true
    
    let cellReuseIdentifier = "EventTableViewCell"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchAppData()

        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.leftBarButtonItem  = menuBtn
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.navigationItem.rightBarButtonItem  = add

        
        
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            tableViewEvent.refreshControl = refreshControl
        } else {
            tableViewEvent.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(displayP3Red: 0.0196, green: 0.6039, blue: 0.8196, alpha: 1.0)
        
        tableViewEvent.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    @objc func openMenu ()
    {
        panel?.openLeft(animated: true)
    }
    @objc func addTapped ()
    {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Channel Addition Request"
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
    
    @objc private func refreshData(_ sender: Any) {
        
        fetchAppData()
    }
    

    // MARK: Netwrok Calling
    func fetchAppData()
    {
        self.view.makeToastActivity(.center)
        APIManager.sharedInstance.fetchDataWithAppID(onSuccess: { json in
            
            DispatchQueue.main.async
            {
                self.view.hideToastActivity()
                self.refreshControl.endRefreshing()
            }

            let live = json["live"].boolValue
            
            if live
            {
                self.parseNetworkDataAndUpdateUI(json: json)
            }else
            {
                APP_DELEGATE().blockApplication(message: APP_DISABLED_MESSAGE)
            }
            
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
            DispatchQueue.main.async
            {
                self.view.hideToastActivity()
                self.refreshControl.endRefreshing()

            }
            
        })
    }
    
    // MARK: Data Parsing
    func parseNetworkDataAndUpdateUI(json: JSON)
    {
        AdsManager.sharedInstance.adsData  = getAdsFromRespns(json: json)
        if isFirstTime
        {
            AdsManager.sharedInstance.showInterstatial(nil, location: "start")
            for config in json["application_configurations"].arrayValue
            {
                let key = config["key"].stringValue
                if key == "ShowSplash"
                {
                    let showSplash:Bool = config["value"].boolValue
                    if showSplash
                    {
                        DispatchQueue.main.async
                        {
                            APP_DELEGATE().loadSplashScreenWithConfiguration(json: json)
                        }
                        isFirstTime = false
                    }
                }
            }
        }
//        AdsManager.sharedInstance.showBanner(self.view)        
        //GetEventsFrom respnse is the parser function of Response class
        tableDataArray = getEventsFromRespns(json: json)
        DispatchQueue.main.async
        {
            self.tableViewEvent.reloadData()
        }
    }
    
    // MARK: TableView Data Source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 300
        }
        else
        {
            // Iphone
            return 180
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EventTableViewCell

        
        cell.contentView.layoutIfNeeded()
        
        // Configure the cell...
        
        let event: Event = tableDataArray[indexPath.row]
        
        cell.loadEvent(event: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let event: Event = tableDataArray[indexPath.row]
        performSegue(withIdentifier: "showCategoryChannels", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "showCategoryChannels") {
            // pass data to next view
            let channelVC = segue.destination as! ChannelsViewController
            channelVC.event = sender as? Event
        }
    }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

