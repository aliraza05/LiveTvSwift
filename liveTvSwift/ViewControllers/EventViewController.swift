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
        
        tableViewEvent.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAppData()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Netwrok Calling
    func fetchAppData()
    {
        self.view.makeToastActivity(.center)
        APIManager.sharedInstance.fetchDataWithAppID(appID: 5, onSuccess: { json in
            
            DispatchQueue.main.async
            {
                self.view.hideToastActivity()
            }

            self.parseNetworkDataAndUpdateUI(json: json)
        }, onFailure: { error in
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.show(alert, sender: nil)
            DispatchQueue.main.async
            {
                self.view.hideToastActivity()
            }
            
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
                        DispatchQueue.main.async
                        {
                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.loadSplashScreenWithConfiguration(json: json)
                        }
                        isFirstTime = false
                    }
                }
            }
        }
        //GetEventsFrom respnse is the parser function of Response class
        tableDataArray = getEventsFromRespns(json: json)
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: EventTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! EventTableViewCell

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
}

