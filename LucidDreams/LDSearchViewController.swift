//
//  LDSearchViewController.swift
//  LucidDreams
//
//  Created by Pablo on 7/10/16.
//
//

import UIKit
import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import RxDelegateCells

struct MySection {
    
    var header: String
    var items: [Item]
    
}

extension MySection : AnimatableSectionModelType {
    
    typealias Item = Int
    
    var identity: String {
        
        return header
        
    }
    
    init(original: MySection, items: [Item]) {
        
        self       = original
        self.items = items
        
    }
    
}

class LDSearchViewController: LDViewController {
    
    private var viewModel:   LDGifViewModel!
    private let disposeBag = DisposeBag()
    
    private var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
    
    private var searchTextField: UITextField!
    
    var lastSearch: Observable<String> {
        
        return searchTextField
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.searchTextField = (self.navigationController as! LDSearchNavigationController).searchTextField
        
        self.viewModel = LDGifViewModel(searchQuery: lastSearch)
        
        bindUI()
        
        registerTableViewCell()
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Private Methods
    
    private func bindUI() {
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>()
        
        dataSource.configureCell = { ds, tv, ip, item in
            
            let cell = tv.dequeueReusableCellWithIdentifier(LDGIFCell.identifier, forIndexPath: ip)
            
//            (cell as! LDGIFCell).gif = (ds.itemAtIndexPath(ip) as! LDGif)
            
            print(item)
            
            return cell
            
        }
        
        self.viewModel.fetchGifs()
            .bindTo(self.tableView.rx_itemsWithDataSource(dataSource)).add
        
        self.tableView.rx_setDelegate(self)
            .addDisposableTo(disposeBag)
        
//        self.viewModel
//            .fetchGifs()
//            .bindTo(self.tableView.rx_itemsWithCellFactory) { (tableView, row, item) in
//                
//                let cell = tableView.dequeueReusableCellWithIdentifier(LDGIFCell.identifier, forIndexPath: NSIndexPath(forRow: row, inSection: 0))
//                
//                (cell as! LDGIFCell).gif = item
//                
//                return cell
//            }
//            .addDisposableTo(self.disposeBag)
        
        searchTextField.rx_text.asObservable()
            .subscribeNext { [weak self] x in
                
                self?.searchTextField.text = x.uppercaseString
                
            }
            .addDisposableTo(self.disposeBag)
        
        tableView.rx_delegate.observe(#selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:)))
            .subscribeNext { [weak self] x in
                
                self?.searchTextField.resignFirstResponder()
                
            }
            .addDisposableTo(self.disposeBag)
        
    }
    
    private func registerTableViewCell() {
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier)
        
    }
    
    // MARK: - Action Methods
    
    @IBAction func dimiss(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

extension LDSearchViewController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        print(dataSource?.itemAtIndexPath(indexPath))
        
        return CGFloat(100)
        
    }
}