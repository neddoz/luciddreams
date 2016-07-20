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

class LDSearchViewController: LDViewController {
    
    static let startLoadingOffset: CGFloat = 20.0
    
    private var viewModel: LDSearchViewModel!
    
    var searchTextField: UITextField!
    
//    var lastSearch: Driver<String> {
//        
//        return self.searchTextField
//            .rx_text
//            .asDriver()
//            .throttle(0.3)
//            .distinctUntilChanged()
//        
//    }
    
    override func viewDidLoad() {
        
        _ = self.searchTextField
            .rx_text
            .asDriver()
            .throttle(0.3)
            .distinctUntilChanged()
        
        super.viewDidLoad()
        
        self.searchTextField = (self.navigationController as! LDSearchNavigationController).searchTextField
        
//        self.viewModel = LDSearchViewModel(gifs: [], searchQuery: lastSearch)
        
        reactiveSetup()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private Methods
    
    private func reactiveSetup() {
        
//        searchTextField.rx_text.asObservable()
//            .subscribeNext { [weak self] x in
//                
//                self?.searchTextField.text = x.uppercaseString
//                
//            }
//            .addDisposableTo(disposeBag)
//        
//        tableView.rx_delegate.observe(#selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:)))
//            .subscribeNext { [weak self] x in
//                
//                self?.searchTextField.resignFirstResponder()
//                
//            }
//            .addDisposableTo(disposeBag)
//        
//        self.viewModel
//            .fetchGifs()
//            .shareReplay(1)
//            .map {
//                
//                return LDSearchViewModel(gifs: $0, searchQuery: self.lastSearch)
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
//            .bindTo(self.tableView.rx_itemsWithDataSource(self.dataSource))
//            .addDisposableTo(self.disposeBag)
        
        //        self.refreshControl.rx_controlEvent(.ValueChanged)
        //            .subscribeNext { _ in
        //
        //                self.viewModel.fetchGifs()
        //
        //                self.refreshControl.endRefreshing()
        //
        //            }
        //            .addDisposableTo(self.disposeBag)
        //
        //        self.activityIndicator.asObservable()
        //            .bindTo(refreshControl.rx_refreshing)
        //            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_setDelegate(self)
            .addDisposableTo(self.disposeBag)
        
        
        
        
        
//        let loadNextPageTrigger = tableView.rx_contentOffset
//            .flatMap { offset in
//                LDSearchViewController.isNearTheBottomEdge(offset, self.tableView)
//                    ? Observable.just()
//                    : Observable.empty()
//        }
//        
//        let searchResult = self.searchTextField.rx_text.asDriver()
//            .throttle(0.3)
//            .distinctUntilChanged()
//            .flatMapLatest { query -> Driver<RepositoriesState> in
//                if query.isEmpty {
//                    return Driver.just(RepositoriesState.empty)
//                } else {
//                    return GitHubSearchRepositoriesAPI.sharedAPI.search(query, loadNextPageTrigger: loadNextPageTrigger)
//                        .asDriver(onErrorJustReturn: RepositoriesState.empty)
//                }
//        }
//        
//        searchResult
//            .map { $0.serviceState }
//            .drive(navigationController!.rx_serviceState)
//            .addDisposableTo(disposeBag)
//        
//        searchResult
//            .map { [SectionModel(model: "Repositories", items: $0.repositories)] }
//            .drive(tableView.rx_itemsWithDataSource(dataSource))
//            .addDisposableTo(disposeBag)
//        
//        searchResult
//            .filter { $0.limitExceeded }
//            .driveNext { n in
//                showAlert("Exceeded limit of 10 non authenticated requests per minute for GitHub API. Please wait a minute. :(\nhttps://developer.github.com/v3/#rate-limiting")
//            }
//            .addDisposableTo(disposeBag)
        
    }
    
    static func isNearTheBottomEdge(contentOffset: CGPoint, _ tableView: UITableView) -> Bool {
        
        return contentOffset.y + tableView.frame.size.height + startLoadingOffset > tableView.contentSize.height
        
    }
    
    // MARK: - Action Methods
    
    @IBAction func dimiss(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}