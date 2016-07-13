//
//  ViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import SwiftyJSON
import CocoaLumberjack

private let kLDEstimatedRowHeight: CGFloat = 200.0

class LDHomeViewController: LDViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak private var tableView: UITableView!
    
    private var arrayGIFs: Array<LDGIF> = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.backgroundColor    = UIColor.clearColor()
        self.tableView.rowHeight          = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = kLDEstimatedRowHeight
        
        registerTableViewCell()
        
        loadTrendingGIFs()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private Methods
    
    private func registerTableViewCell() {
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier())
    }
    
    private func loadTrendingGIFs() {
        
        GiphyProvider.request(.Trend, completion: { (result) in
            
            switch result {
            case let .Success(response):
                do {
                    
                    let responseObj = try response.mapObject(LDResponse)
                    
                    self.arrayGIFs = responseObj.GIFs
                    
                    self.tableView.reloadData()
                    
                    DDLogInfo("\(JSON(data: response.data))")
                    
                } catch {
                    guard let error = error as? CustomStringConvertible else {
                        break
                    }
                    
                    print(error.description)
                }
            case let .Failure(error):
                
                print(error)
            }
            
        })
    }
    
    // MARK: - TableView DataSource Methods
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return tableView.dequeueReusableCellWithIdentifier(LDGIFCell.identifier())!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayGIFs.count
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        (cell as! LDGIFCell).loadGIF((self.arrayGIFs[indexPath.row].image?.url)!)
    }
    
}

