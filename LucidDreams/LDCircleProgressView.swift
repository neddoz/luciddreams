//
//  LDswift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/15/16.
//
//

import UIKit
import CircleProgressView

class LDCircleProgressView: CircleProgressView {

    required init(frame: CGRect) {
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.progress             = 0.00
        self.backgroundColor      = UIColor.clearColor()
        self.clockwise            = true
        self.trackWidth           = 7.0
        self.centerImage          = nil
        self.trackImage           = nil
        self.trackFillColor       = UIColor.whiteColor()
        self.trackBackgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.30)
    }
    
    func resetCircularProgress() {
        
        self.progress = 0.00
        self.alpha    = 1.00
    }

}
