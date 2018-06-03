//
//  SecondViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 26/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var categoryTableView: UITableView!
    private let refreshControl = UIRefreshControl()

    let cellReuseIdentifier = "CategoriesTableViewCell"
    var tableDataArray : [Event] = []
    var canShowAd:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.leftBarButtonItem  = menuBtn
        
        fetchAppData()

        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            categoryTableView.refreshControl = refreshControl
        } else {
            categoryTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor(displayP3Red: 0.0196, green: 0.6039, blue: 0.8196, alpha: 1.0)
        
        categoryTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }

    @objc func openMenu ()
    {
        panel?.openLeft(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if canShowAd
        {
            AdsManager.sharedInstance.showInterstatial(nil, location:"catstart")
            canShowAd = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        //GetEventsFrom respnse is the parser function of Response class
        tableDataArray = getCategoriesFromRespns(json: json)
        DispatchQueue.main.async
        {
                self.categoryTableView.reloadData()
        }
    }
    
    // MARK: TableView Data Source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 415
        }
        else
        {
            // Iphone
            return 275
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: CategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CategoriesTableViewCell
        
        // Configure the cell...
        
        let event: Event = tableDataArray[indexPath.row]
        
        cell.loadChannel(event: event)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        canShowAd = true
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

