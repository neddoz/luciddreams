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

class LDViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = LDViewController.configureDataSource()
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
    
    static private func configureDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, LDGif>> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, LDGif>>()
        
        dataSource.configureCell = { (_, tv, ip, gif: LDGif) in
            
            let cell = tv.dequeueReusableCellWithIdentifier(LDGIFCell.identifier)!
            
            (cell as! LDGIFCell).gif = gif
            
            return cell
            
        }
        
        return dataSource
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