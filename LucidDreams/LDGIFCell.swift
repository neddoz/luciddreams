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
    
    func loadGIF(url: NSURL) {
        
        self.gifImageView.setShowActivityIndicatorView(true);
        self.gifImageView.setIndicatorStyle(.Gray)
        
        self.gifImageView.contentMode = .ScaleAspectFill
        
        self.gifImageView .sd_setImageWithURL(url, placeholderImage: nil, options: .ContinueInBackground)

    }
    
}
