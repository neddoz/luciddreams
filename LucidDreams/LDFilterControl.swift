//
//  LDFilterControl.swift
//  LucidDreams
//
//  Created by Pablo on 7/11/16.
//
//

import UIKit

class LDFilterControl: UIView {
    
    @IBOutlet weak var view:         UIView!
    @IBOutlet weak var trendingView: UIView!
    @IBOutlet weak var newestView:   UIView!
    
    @IBOutlet weak var markerView: UIView!
    
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var newestLabel:   UILabel!
    
    let trendingTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    let newestTapGesture:   UITapGestureRecognizer = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        nibSetup()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        nibSetup()
        commonInit()
    }
    
    private func nibSetup() {
        
        view                                           = loadViewFromNib()
        view.frame                                     = bounds
        view.autoresizingMask                          = [.FlexibleWidth, .FlexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func commonInit() {
        
        self.trendingTapGesture.addTarget(self,
                                          action: #selector(trendingAction))
        
        self.newestTapGesture.addTarget(self,
                                          action: #selector(newestAction))
        
        self.trendingTapGesture.numberOfTapsRequired    = 1
        self.trendingTapGesture.numberOfTouchesRequired = 1
        self.newestTapGesture.numberOfTapsRequired      = 1
        self.newestTapGesture.numberOfTouchesRequired   = 1
    
        self.trendingView.addGestureRecognizer(self.trendingTapGesture)
        self.newestView.addGestureRecognizer(self.newestTapGesture)
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        self.markerView.center = self.trendingLabel.center
    }
    
    func trendingAction(sender: AnyObject? = nil) {
        
        self.animateControlToOriginX(self.trendingView.x + self.trendingLabel.x);
    }
    
    func newestAction(sender: AnyObject? = nil) {
        
        self.animateControlToOriginX(self.newestView.x + self.newestLabel.x);
    }
    
    private func animateControlToOriginX(originX: CGFloat) {
        
        UIView.animateWithDuration(0.17) {
            
            self.markerView.x = originX;
            
        }
    }
    
}
