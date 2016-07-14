//
//  LDGIFCell.swift
//  LucidDreams
//
//  Created by Pablo Epíscopo on 7/13/16.
//
//

import UIKit
import SDWebImage

class LDGIFCell: UITableViewCell {

    @IBOutlet weak private var gifImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.gifImageView.backgroundColor = randomPlaceholderColor()
        self.backgroundColor              = UIColor.clearColor()
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
    
    func loadGIF(url: NSURL) {
        
        self.gifImageView.setShowActivityIndicatorView(true);
        self.gifImageView.setIndicatorStyle(.White)
        
        self.gifImageView.contentMode = .ScaleAspectFill
        
        self.gifImageView .sd_setImageWithURL(url, placeholderImage: nil, options: .CacheMemoryOnly)
    }
    
}

extension LDGIFCell {
    
    func randomPlaceholderColor() -> UIColor {
        
        let array: Array<UIColor> = [
            UIColor.purple65GiphyColor(),
            UIColor.pastelRed65GiphyColor(),
            UIColor.skyBlue65GiphyColor(),
            UIColor.green65GiphyColor(),
            UIColor.yellow65GiphyColor()
        ]

        let randomIndex = Int(arc4random_uniform(UInt32(array.count)))
        
        return array[randomIndex]
    }
    
}
