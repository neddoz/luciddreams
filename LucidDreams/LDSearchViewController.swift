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

class LDSearchViewController: LDViewController {
    
    private var viewModel:   LDGifViewModel!
    private let disposeBag = DisposeBag()
    
    var searchTextField: UITextField!
    
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
        
        self.viewModel
            .fetchGifs()
            .bindTo(tableView.rx_itemsWithCellFactory) { (tableView, row, item) in
                
                let cell = tableView.dequeueReusableCellWithIdentifier(LDGIFCell.identifier, forIndexPath: NSIndexPath(forRow: row, inSection: 0))
                
                (cell as! LDGIFCell).gif = item
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        searchTextField.rx_text.asObservable()
            .subscribeNext { [weak self] x in
                
                self?.searchTextField.text = x.uppercaseString
                
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_delegate.observe(#selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:)))
            .subscribeNext { [weak self] x in
                
                self?.searchTextField.resignFirstResponder()
                
            }
            .addDisposableTo(disposeBag)
        
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