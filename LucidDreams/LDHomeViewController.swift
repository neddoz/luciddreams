//
//  ViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import RxSwift
import RxCocoa
import BRYXBanner
import CocoaLumberjack

class LDHomeViewController: LDViewController, UITableViewDataSource, UITableViewDelegate  {
    
    private var arrayGIFs: Array<LDGif> = []
    
    @IBOutlet weak private var filterControl: LDFilterControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor  = UIColor.clearColor()
        
        self.filterControl.didChangeFiltering = { (state: LDFilterControl.LDFiltering) -> Void in
            
        }
        
        registerTableViewCell()
        
        loadTrendingGIFs()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func refreshAction() {
        
        loadTrendingGIFs()
    }
    
    // MARK: - Private Methods
    
    private func registerTableViewCell() {
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier)
    }
    
    private func loadTrendingGIFs() {
        
//        GiphyProvider.request(.Trend, completion: { (result) in
//            
//            switch result {
//                
//            case let .Success(response):
//                
//                self.refreshControl.endRefreshing()
//                
//                if response.statusCode != 200 {
//                    
//                    Banner.showErrorBanner()
//                    
//                    return
//                }
//                
//                let responseObj = LDResponse(jsonData: JSON(data: response.data))
//                
//                self.arrayGIFs = responseObj!.GIFs
//                
//                self.tableView.reloadData()
//                
//                DDLogInfo("\(JSON(data: response.data))")
//                
//            case let .Failure(error):
//                
//                self.refreshControl.endRefreshing()
//                
//                Banner.showErrorBanner()
//                
//                guard let error = error as? CustomStringConvertible else {
//                    break
//                }
//                
//                DDLogError(error.description)
//            }
//            
//        })
    }
    
    // MARK: - TableView DataSource Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCellWithIdentifier(LDGIFCell.identifier,
                                                           forIndexPath: indexPath) as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayGIFs.count
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! LDGIFCell).gif = self.arrayGIFs[indexPath.row]
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return self.arrayGIFs[indexPath.row].heightForScreenWidth(self.view.width) + LDGIFCell.separatorHeight
//    }
    
}