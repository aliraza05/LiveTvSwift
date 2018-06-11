//
//  NewsViewController.swift
//  LiveSportsTVHD
//
//  Created by Ali  Raza on 03/06/2018.
//  Copyright © 2018 BroadPeak. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController,UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var pageControll: UIPageControl!
    @IBOutlet weak var noNews_lbl: UILabel!
    var newsList : [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAppData()
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(openMenu))
        self.navigationItem.leftBarButtonItem  = menuBtn

        noNews_lbl.isHidden = true
        
        pageControll.numberOfPages = 0
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func openMenu ()
    {
        panel?.openLeft(animated: true)
    }
    
    // MARK: Netwrok Calling
    func fetchAppData()
    {
        self.view.makeToastActivity(.center)
        APIManager.sharedInstance.fetchDataWithAppID(onSuccess: { json in
            
            DispatchQueue.main.async
                {
                    self.view.hideToastActivity()
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
                    
            }
            
        })
    }
    
    // MARK: Data Parsing
    func parseNetworkDataAndUpdateUI(json: JSON)
    {
        newsList = getNewsFromRespns(json: json)
        
        if newsList.count > 0
        {
            DispatchQueue.main.async
            {
                self.newsCollectionView.reloadData()
                self.pageControll.numberOfPages = self.newsList.count
                self.pageControll.currentPage = 0
                
            }
        }else
        {
            DispatchQueue.main.async
            {
                self.noNews_lbl.isHidden = false
                self.newsCollectionView.isHidden = true
                self.pageControll.isHidden = true
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        
        pageControll.currentPage = currentPage
        // Do whatever with currentPage.
    }
    
    // MARK: Collection View Data Source

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    //2
    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return newsList.count
//        return 10

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return (APP_DELEGATE().window?.frame.size)!

    }
    
    
    //3
    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: NewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! NewsCell
        
        let event: Event = newsList[indexPath.row]

        if let url = URL(string: event.image_url)
        {
            cell.newsBg_imgview.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholderSmal"))
        }
        cell.newsTitle_lbl.text = event.name;
        
//        cell.backgroundColor = UIColor.black
        // Configure the cell
        return cell
    }
    

}
