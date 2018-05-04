//
//  SecondViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 26/04/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var channelTableView: UITableView!

    let cellReuseIdentifier = "CategoriesTableViewCell"
    var tableDataArray : [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        channelTableView.register(UINib(nibName: "CategoriesTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchAppData()
    }
    override func didReceiveMemoryWarning() {
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
        
        //GetEventsFrom respnse is the parser function of Response class
        tableDataArray = getEventsFromRespns(json: json)
        DispatchQueue.main.async
            {
                self.channelTableView.reloadData()
        }
    }
    
    // MARK: TableView Data Source
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
}

