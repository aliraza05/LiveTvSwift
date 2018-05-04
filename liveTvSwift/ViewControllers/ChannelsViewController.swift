//
//  ChannelsViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class ChannelsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView_channel: UITableView!
    @IBOutlet weak var channelName_lbl: UILabel!
    
    let cellReuseIdentifier = "ChannelTableViewCell"
    var tableDataArray : [Channel] = []
    var event:Event?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView_channel.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        if ((event?.channels) != nil)
        {
            tableDataArray = (event?.channels)!
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: TableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tableDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: ChannelTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ChannelTableViewCell
        
        // Configure the cell...
        
        let channel: Channel = tableDataArray[indexPath.row]
        
        cell.loadChannel(channel: channel)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
