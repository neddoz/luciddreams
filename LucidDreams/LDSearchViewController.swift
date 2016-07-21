//
//  LDSearchViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import RxSwift
import RxCocoa
import BRYXBanner
import Foundation
import RxDataSources
import UITableView_NXEmptyView

class LDSearchViewController: LDViewController, UITableViewDelegate {
    
    let      refreshControl = UIRefreshControl()
    let      dataSource     = LDSearchViewController.configureDataSource()
    lazy var viewModel      = LDSearchViewModel()
    
    var searchTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.refreshControl.tintColor = UIColor.yellowGiphyColor()
        
        self.tableView.addSubview(self.refreshControl)
        
        self.searchTextField = (self.navigationController as! LDSearchNavigationController).searchTextField
        
        reactiveSetup()
        
    }
    
    // MARK: - Private Methods
    
    private func reactiveSetup() {
        
        self.searchTextField.rx_text.asObservable()
            .subscribeNext { [weak self] x in self?.searchTextField.text = x.uppercaseString }
            .addDisposableTo(self.disposeBag)
        
        rx_sentMessage(#selector(LDSearchViewController.viewWillAppear(_:)))
            .skip(1)
            .map { _ in false }
            .bindTo(self.viewModel.refreshTrigger)
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_reachedBottom
            .bindTo(self.viewModel.loadNextPageTrigger)
            .addDisposableTo(self.disposeBag)
        
        Driver.combineLatest(self.viewModel.elements.asDriver(), self.viewModel.firstPageLoading, self.searchTextField.rx_text.asDriver()) { elements, loading, searchText in
            
            return loading || searchText.isEmpty ? [] : elements
            
            }
            .asDriver()
            .map { [SectionModel(model: "", items: $0)] }
            .drive(self.tableView.rx_itemsWithDataSource(self.dataSource))
            .addDisposableTo(self.disposeBag)
        
        self.searchTextField.rx_text
            .filter {
                !$0.isEmpty
            }
            .throttle(0.25, scheduler: MainScheduler.instance)
            .bindTo(self.viewModel.queryTrigger)
            .addDisposableTo(self.disposeBag)
        
        self.searchTextField.rx_text
            .filter { $0.isEmpty }
            .map {
                _ in return []
            }
            .bindTo(self.viewModel.elements)
            .addDisposableTo(self.disposeBag)
        
        self.refreshControl.rx_controlEvent(.ValueChanged)
            .filter { self.refreshControl.refreshing }
            .map { true }
            .bindTo(self.viewModel.refreshTrigger)
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.loading
            .filter { !$0  && self.refreshControl.refreshing }
            .driveNext { _ in self.refreshControl.endRefreshing() }
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_setDelegate(self)
            .addDisposableTo(self.disposeBag)
        
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
    
    @IBAction func dimiss(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: - TableView Delegate Methods
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let gif: LDGif = dataSource.itemAtIndexPath(indexPath)
        
        let gifSize = self.view.width *
            CGFloat((gif.image.height as NSString).floatValue) /
            CGFloat((gif.image.width  as NSString).floatValue)
        
        return gifSize + LDGIFCell.separatorHeight
        
    }
    
}