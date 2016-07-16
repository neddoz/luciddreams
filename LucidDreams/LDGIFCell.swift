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
    
    static let identifier               = String(LDGIFCell)
    static let separatorHeight: CGFloat = 3.0
    
    var GIF: LDGIF? {
        
        didSet {
            
            self.gifImageView.contentMode = .ScaleAspectFill
            
            self.circularProgress.resetCircularProgress()
            
            self.gifImageView.sd_setImageWithURL(GIF?.image?.url,
                                                 placeholderImage: nil,
                                                 options: .ContinueInBackground,
                                                 progress: { (receivedSize: Int, expectedSize: Int) in
                                                    
                                                    self.circularProgress.progress = Double(receivedSize) / Double(expectedSize)
                })
            { (image: UIImage!, error: NSError!, type: SDImageCacheType, url: NSURL!) in
                
                if (error == nil) {
                    
                    self.circularProgress?.alpha = 0.00
                } else {
                    
                    DDLogError(error.description)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let randomColor = randomPlaceholderColor()
        
        self.circularProgress.centerFillColor = randomColor
        self.gifImageView?.backgroundColor    = randomColor
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
    
    // MARK: - Private Methods
    
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
