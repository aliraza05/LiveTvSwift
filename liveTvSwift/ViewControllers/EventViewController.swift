//
//  FirstViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 26/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewEvent: UITableView!
    @IBOutlet weak var dateTime_lbl: UILabel!
    
    var tableDataArray : [Event] = []
    var isFirstTime : Bool = true
    
    let cellReuseIdentifier = "EventTableViewCell"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        fetchAppData()
        
        tableViewEvent.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Netwrok Calling
    func fetchAppData()
    {
        APIManager.sharedInstance.fetchDataWithAppID(appID: 5, onSuccess: { json in
            self.parseNetworkDataAndUpdateUI(json: json)
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
        })
    }
    
    // MARK: Data Parsing
    func parseNetworkDataAndUpdateUI(json: JSON)
    {
        if isFirstTime
        {
            for config in json["application_configurations"].arrayValue
            {
                let key = config["key"].stringValue
                if key == "ShowSplash"
                {
                    let showSplash:Bool = config["value"].boolValue
                    if showSplash
                    {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.loadSplashScreenWithConfiguration(configArray: json["application_configurations"].arrayValue as [AnyObject])
                        
                        isFirstTime = false
                    }
                }
            }
        }
        
        for result in json["events"].arrayValue
        {
            let name = result["name"].stringValue
            let live = result["live"].boolValue
            let status = result["status"].stringValue
            let image_url = result["image_url"].stringValue
            let priority = result["priority"].intValue

            var tempChannels : [Channel] = []
            
            for channel in result["channels"].arrayValue
            {
                let name = channel["name"].stringValue
                let live = channel["live"].boolValue
                let url = channel["url"].stringValue
                let image_url = channel["image_url"].stringValue
                let priority = channel["priority"].intValue
                let channel_type = channel["channel_type"].stringValue
                
                tempChannels.append(Channel(name: name, live: live, url: url, image_url: image_url, priority: priority, channel_type: channel_type))
            }
            
            tableDataArray.append(Event(name: name, live: live, status: status, image_url: image_url, priority: priority, channels: tempChannels))
        }
        DispatchQueue.main.async
        {
            self.tableViewEvent.reloadData()
        }
    }
    
    // MARK: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EventTableViewCell

        // Configure the cell...
        
        let event: Event = tableDataArray[indexPath.row]
        
        cell.loadEvent(event: event)
        
        return cell
    }
}

