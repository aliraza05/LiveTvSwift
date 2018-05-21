//
//  ChannelsViewController.swift
//  liveTvSwift
//
//  Created by Ali Raza on 04/05/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit
import BMPlayer
import NVActivityIndicatorView
import AVFoundation

class ChannelsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView_channel: UITableView!
    @IBOutlet weak var channelName_lbl: UILabel!
    
    let cellReuseIdentifier = "ChannelTableViewCell"
    var tableDataArray : [Channel] = []
    var event:Event?
    var player: BMPlayer!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView_channel.register(UINib(nibName: "ChannelTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)

        channelName_lbl.text = event?.name
        
        if ((event?.channels) != nil)
        {
            tableDataArray = (event?.channels)!
        }
        
        setupPlayerManager()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationDidEnterBackground),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: nil)
        
        // Do any additional setup after loading the view.
    }

    @objc func applicationWillEnterForeground() {
        player.play()
    }
    
    @objc func applicationDidEnterBackground() {
        player.pause(allowAutoPlay: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        // If use the slide to back, remember to call this method
        // 使用手势返回的时候，调用下面方法手动销毁
        if (player) != nil
        {
            player.prepareToDealloc()
            print("VideoPlayViewController Deinit")
        }
    }

    // MARK: TableView Data Source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
        {
            // Ipad
            return 200
        }
        else
        {
            // Iphone
            return 90
        }
    }
    
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
        
        APP_DELEGATE().myOrientation = .all

        preparePlayer()
        let channel: Channel = tableDataArray[indexPath.row]

        setupPlayerResource(channel: channel)
    }
    
    // MARK:- BMPlayer Functions
    /**
     prepare playerView
     */
    func preparePlayer() {
        var controller: BMPlayerControlView? = nil
        
        //        controller = BMPlayerControlView()
        controller = BMPlayerCustomControlView()
        
        player = BMPlayer(customControlView: controller)
        
        player.alpha = 0.0
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar

        APP_DELEGATE().window?.rootViewController?.view.addSubview(player)
//        APP_DELEGATE().window?.addSubview(player)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.player.alpha = 1.0
        })
        
        //        view.addSubview(player)
        
        player.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        player.delegate = self
        player.backBlock = { [unowned self] (isFullScreen) in
            
            APP_DELEGATE().myOrientation = .portrait
            UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar


            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.player.alpha = 0.0

            }, completion: {
                (finished: Bool) -> Void in
                self.player.pause(allowAutoPlay: false)
                self.player.removeFromSuperview()
                if (self.player) != nil
                {
                    self.player.prepareToDealloc()
                }
            })
            
            AdsManager.sharedInstance.showInterstatial(nil, location: "aftervideo")
        }
        
        
        self.view.layoutIfNeeded()
    }
    func setupPlayerResource(channel: Channel) {
     
        let asset = BMPlayerResource(url: URL(string: channel.url)!,
                                     name: channel.name)
        
        
        player.setVideo(resource: asset)
        AdsManager.sharedInstance.showInterstatial(nil, location: "beforevideo")
    }
    
    func setupPlayerManager() {
        resetPlayerManager()
        BMPlayerConf.shouldAutoPlay = true

    }
    func resetPlayerManager() {
        BMPlayerConf.allowLog = false
        BMPlayerConf.shouldAutoPlay = true
        BMPlayerConf.tintColor = UIColor.white
        BMPlayerConf.topBarShowInCase = .always
        BMPlayerConf.loaderType  = NVActivityIndicatorType.ballRotateChase
    }
    
    open override var prefersStatusBarHidden: Bool {
        return true }

}
// MARK:- BMPlayerDelegate example
extension ChannelsViewController: BMPlayerDelegate {
    // Call when player orinet changed
    func bmPlayer(player: BMPlayer, playerOrientChanged isFullscreen: Bool) {
//        player.snp.remakeConstraints { (make) in
//            make.top.equalTo(view.snp.top)
//            make.left.equalTo(view.snp.left)
//            make.right.equalTo(view.snp.right)
//            if isFullscreen {
//                make.bottom.equalTo(view.snp.bottom)
//            } else {
//                make.height.equalTo(view.snp.width).multipliedBy(9.0/16.0).priority(500)
//            }
//        }
    }
    
    // Call back when playing state changed, use to detect is playing or not
    func bmPlayer(player: BMPlayer, playerIsPlaying playing: Bool) {
        print("| BMPlayerDelegate | playerIsPlaying | playing - \(playing)")
    }
    
    // Call back when playing state changed, use to detect specefic state like buffering, bufferfinished
    func bmPlayer(player: BMPlayer, playerStateDidChange state: BMPlayerState) {
        print("| BMPlayerDelegate | playerStateDidChange | state - \(state)")
    }
    
    // Call back when play time change
    func bmPlayer(player: BMPlayer, playTimeDidChange currentTime: TimeInterval, totalTime: TimeInterval) {
                print("| BMPlayerDelegate | playTimeDidChange | \(currentTime) of \(totalTime)")
    }
    
    // Call back when the video loaded duration changed
    func bmPlayer(player: BMPlayer, loadedTimeDidChange loadedDuration: TimeInterval, totalDuration: TimeInterval) {
                print("| BMPlayerDelegate | loadedTimeDidChange | \(loadedDuration) of \(totalDuration)")
    }
}
