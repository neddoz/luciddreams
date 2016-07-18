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
import RxDataSources
import CocoaLumberjack

class LDHomeViewController: LDViewController, UITableViewDataSource, UITableViewDelegate  {
    
    private let dataSource = LDHomeViewController.configureDataSource()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var filterControl: LDFilterControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor  = UIColor.clearColor()
        
//        self.filterControl.didChangeFiltering = { (state: LDFilterControl.LDFiltering) -> Void in
//            
//        }
        
        tableViewSetup()
        reactiveSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func refreshAction() {
        
        loadTrendingGIFs()
        
    }
    
    // MARK: - Private Methods
    
    private func tableViewSetup() {
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor  = UIColor.clearColor()
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier)
        
    }
    
    private func reactiveSetup() {
        
        let trendingGIFs = RandomUserAPI.sharedAPI
            .getExampleUserResultSet()
            .map {
                
                return LDTrendingViewModel(gifs: $0)
                
            }
            .observeOn(MainScheduler.instance)
        
        trendingGIFs
            .map {
                
                [SectionModel(model: "", items: $0.users)]
                
            }
            .shareReplay(1)
            .bindTo(tableView.rx_itemsWithDataSource(dataSource))
            .addDisposableTo(disposeBag)
        
        tableView.rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
    }
    
    static private func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, LDGif>> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, LDGif>>()
        
        dataSource.configureCell = { (_, tv, ip, gif: LDGif) in
            
            let cell = tv.dequeueReusableCellWithIdentifier(LDGIFCell.identifier)!
            
            (cell as! LDGIFCell).gif = gif
            
            return cell
            
        }
        
        return dataSource
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let gif: LDGif = dataSource.itemAtIndexPath(indexPath)
        
        return gif.image. + LDGIFCell.separatorHeight
        
    }
    
}