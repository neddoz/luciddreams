//
//  LDFilterControl.swift
//  LucidDreams
//
//  Created by Pablo on 7/11/16.
//
//

import UIKit

class LDFilterControl: UIView {
    
    enum LDFiltering {
        
        case LDFilteringTrending
        case LDFilteringRandom
    }
    
    @IBOutlet weak private var view:         UIView!
    @IBOutlet weak private var trendingView: UIView!
    @IBOutlet weak private var randomView:   UIView!
    
    @IBOutlet weak private var markerView: UIView!
    
    @IBOutlet weak private var trendingLabel: UILabel!
    @IBOutlet weak private var randomLabel:   UILabel!
    
    let trendingTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    let randomTapGesture:   UITapGestureRecognizer = UITapGestureRecognizer()
    
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
                                          action: #selector(trendingAction(_:)))
        
        self.randomTapGesture.addTarget(self,
                                        action: #selector(randomAction(_:)))
        
        self.trendingTapGesture.numberOfTapsRequired    = 1
        self.trendingTapGesture.numberOfTouchesRequired = 1
        self.randomTapGesture.numberOfTapsRequired      = 1
        self.randomTapGesture.numberOfTouchesRequired   = 1
        
        self.trendingView.addGestureRecognizer(self.trendingTapGesture)
        self.randomView.addGestureRecognizer(self.randomTapGesture)
    }
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
        
        self.markerView.center = self.trendingLabel.center
    }
    
    @objc private func trendingAction(sender: AnyObject?) {
        
        self.animateControlToOriginX(self.trendingView.x + self.trendingLabel.x);
    }
    
    @objc private func randomAction(sender: AnyObject?) {
        
        self.animateControlToOriginX(self.randomView.x + self.randomLabel.x);
    }
    
    private func animateControlToOriginX(originX: CGFloat) {
        
        UIView.animateWithDuration(0.17) {
            
            self.markerView.x = originX;
            
        }
    }
    
}
