//
//  LDGIFCell.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/13/16.
//
//

import UIKit
import SDWebImage
import CocoaLumberjack

class LDGIFCell: UITableViewCell {
    
    @IBOutlet weak private var gifImageView:     UIImageView!
    @IBOutlet weak private var trendTag:         UIView!
    @IBOutlet weak private var circularProgress: LDCircleProgressView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let randomColor = randomPlaceholderColor()
        
        self.circularProgress.centerFillColor = randomColor
        self.gifImageView?.backgroundColor       = randomColor
        self.backgroundColor                  = UIColor.clearColor()
        self.selectionStyle                   = .None
        self.trendTag.alpha                   = 0.0
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        gifImageView.image = nil
        
        gifImageView.sd_cancelCurrentImageLoad()
    }
    
    // MARK: - Public Methods
    
    static func identifier() -> String {
        
        return String(LDGIFCell)
    }
    
    static func separatorHeight() -> CGFloat {
        
        return 3.0
    }
    
    func loadGIF(gif: LDGIF) {
        
        self.gifImageView.contentMode = .ScaleAspectFill
        
        self.circularProgress.resetCircularProgress()
        
        self.gifImageView.sd_setImageWithURL(gif.image?.url,
                                             placeholderImage: nil,
                                             options: .ContinueInBackground,
                                             progress: { (receivedSize: Int, expectedSize: Int) in
                                                
                                                self.circularProgress.progress = Double(receivedSize) / Double(expectedSize)
            })
        { (image: UIImage!, error: NSError!, type: SDImageCacheType, url: NSURL!) in
            
            // Check for error!
            
            self.circularProgress?.alpha = 0.00
        }
    }
    
    func randomPlaceholderColor() -> UIColor {
        
        let array: Array<UIColor> = [
            
            UIColor.purple65GiphyColor(),
            UIColor.pastelRed65GiphyColor(),
            UIColor.skyBlue65GiphyColor(),
            UIColor.green65GiphyColor(),
            UIColor.yellow65GiphyColor()
        ]
        
        let randomIndex = Int(rand()) % array.count
        
        return array[randomIndex]
    }
}
