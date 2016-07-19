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

class LDHomeViewController: LDViewController  {
    
    let viewModel         = LDTrendingViewModel(gifs: [])
    let activityIndicator = ActivityIndicator()
    
    var gifs:           Observable<[LDGif]?>!
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak private var filterControl: LDFilterControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.refreshControl           = UIRefreshControl()
        self.refreshControl.tintColor = UIColor.yellowGiphyColor()
        
        self.tableView.addSubview(refreshControl)
        
        reactiveSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private Methods
    
    private func reactiveSetup() {
        
        self.refreshControl.rx_controlEvent(.ValueChanged)
            .subscribeNext { _ in
                
                self.gifs = self.viewModel.fetchTrend()
                
                self.refreshControl.endRefreshing()
                
            }
            .addDisposableTo(self.disposeBag)
        
        self.activityIndicator.asObservable()
            .bindTo(refreshControl.rx_refreshing)
            .addDisposableTo(self.disposeBag)
        
        self.gifs = self.viewModel.fetchTrend()
        
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
            .addDisposableTo(self.disposeBag)
        
    }
    
}