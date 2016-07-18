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

class LDHomeViewController: LDViewController, UITableViewDelegate  {
    
    private let dataSource = LDHomeViewController.configureDataSource()
    private let disposeBag = DisposeBag()
    
    let model = LDTrendingViewModel(gifs: [])
    
    var gifs: Observable<[LDGif]?>!
    
    @IBOutlet weak private var filterControl: LDFilterControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableViewSetup()
        reactiveSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    override func refreshAction() {
        
        print("** TO-DO **")
        
    }
    
    // MARK: - Private Methods
    
    private func tableViewSetup() {
        
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.separatorColor  = UIColor.clearColor()
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier)
        
    }
    
    private func reactiveSetup() {
        
        self.refreshControl.rx_controlEvent(.ValueChanged)
            .subscribeNext { [weak self] _ in
                
                self!.gifs = self!.model.fetchTrend()
                
                self?.refreshControl.endRefreshing()
                
            }
            .addDisposableTo(self.disposeBag)
        
        self.activityIndicator.asObservable()
            .bindTo(refreshControl.rx_refreshing)
            .addDisposableTo(self.disposeBag)
        
        self.gifs = self.model.fetchTrend()
        
        self.gifs
            .map {
                
                return LDTrendingViewModel(gifs: $0!)
                
            }
            .map {
                
                [SectionModel(model: "", items: $0.gifs)]
                
            }
            .doOnError() { x in
                
                Banner.showErrorBanner()
                
            }
            .observeOn(MainScheduler.instance)
            .shareReplay(1)
            .bindTo(self.tableView.rx_itemsWithDataSource(self.dataSource))
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_setDelegate(self)
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
        
        let gifSize = self.view.width *
            CGFloat((gif.image.height as NSString).floatValue) /
            CGFloat((gif.image.width  as NSString).floatValue)
        
        return gifSize + LDGIFCell.separatorHeight
        
    }
    
}