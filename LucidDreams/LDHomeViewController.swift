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
    
    let viewModel         = LDTrendingViewModel()
    let activityIndicator = ActivityIndicator()
    
    var gifs:           Observable<[LDGif]?>!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    
    @IBOutlet weak private var filterControl: LDFilterControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.refreshControl.tintColor = UIColor.yellowGiphyColor()
        
        self.tableView.addSubview(refreshControl)
        
        reactiveSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private Methods
    
    private func reactiveSetup() {
        
        rx_sentMessage(#selector(LDHomeViewController.viewWillAppear(_:)))
            .map { _ in false }
            .bindTo(viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        //        self.viewModel.loading
        //            .drive(self.activityIndicator.rx_animating)
        //            .addDisposableTo(disposeBag)
        
        self.viewModel.elements.asDriver()
            .asDriver()
            .drive(self.tableView.rx_itemsWithCellIdentifier(LDGIFCell.identifier, cellType: LDGIFCell.self)) { _, gif, cell in
                
                cell.gif = gif
                
            }
            .addDisposableTo(self.disposeBag)
        
        self.refreshControl.rx_controlEvent(.ValueChanged)
            .filter { self.refreshControl.refreshing }
            .map { true }
            .bindTo(self.viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        viewModel.loading
            .filter { !$0 && self.refreshControl.refreshing }
            .driveNext { _ in self.refreshControl.endRefreshing() }
            .addDisposableTo(disposeBag)
        
        //        self.refreshControl.rx_controlEvent(.ValueChanged)
        //            .subscribeNext { _ in
        //
        //                self.gifs = self.viewModel.fetchTrend()
        //
        //                self.refreshControl.endRefreshing()
        //
        //            }
        //            .addDisposableTo(self.disposeBag)
        //
        //        self.activityIndicator.asObservable()
        //            .bindTo(refreshControl.rx_refreshing)
        //            .addDisposableTo(self.disposeBag)
        //
        //        self.gifs = self.viewModel.fetchTrend()
        //
        //        self.gifs
        //            .map {
        //
        //                return LDTrendingViewModel(gifs: $0!)
        //
        //            }
        //            .map {
        //
        //                [SectionModel(model: "", items: $0.gifs)]
        //
        //            }
        //            .doOnError() { x in
        //
        //                Banner.showErrorBanner()
        //
        //            }
        //            .observeOn(MainScheduler.instance)
        //            .shareReplay(1)
        //            .bindTo(self.tableView.rx_itemsWithDataSource(self.dataSource))
        //            .addDisposableTo(self.disposeBag)
        
        //        self.tableView.rx_setDelegate(self)
        //            .addDisposableTo(self.disposeBag)
        
    }
    
}