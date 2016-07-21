//
//  LDViewController.swift
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
import UITableView_NXEmptyView

class LDViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableViewSetup()

    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        return UIStatusBarStyle.LightContent
    }
    
    // MARK: - Private Methods
    
    private func tableViewSetup() {
        
        self.tableView.backgroundColor     = UIColor.clearColor()
        self.tableView.separatorColor      = UIColor.clearColor()
        self.tableView.keyboardDismissMode = .OnDrag
        self.tableView.nxEV_emptyView      = UINib(nibName: "LDEmptyTable", bundle: nil).instantiateWithOwner(nil, options: nil).first as? UIView
        
        let nibName = UINib(nibName: String(LDGIFCell), bundle:nil)
        
        self.tableView.registerNib(nibName, forCellReuseIdentifier: LDGIFCell.identifier)
        
    }
    
}