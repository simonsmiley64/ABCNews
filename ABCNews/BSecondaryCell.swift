//
//  BSecondaryCell.swift
//  ABCNews
//
//  Created by Simon Smiley-Andrews on 12/10/2017.
//  Copyright © 2017 Simon Smiley-Andrews. All rights reserved.
//

import UIKit
import SDWebImage

class BSecondaryCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var storyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configureWithNews(newsItem: BNewsItem) {
        
        titleLabel.text = newsItem.title
        dateLabel.text = newsItem.date
        
//        storyImage.sd_setImage(with: URL(string: newsItem.thumbnailURL!), placeholderImage: UIImage(named: "loading.png"), options: []) { (image, error, type, url) in
//
//            print("Complete")
//        }
        
        //storyImage.sd_setImage(with: <#T##URL?#>, placeholderImage: <#T##UIImage?#>, options: SDWebImageOptions, completed: <#T##SDExternalCompletionBlock?##SDExternalCompletionBlock?##(UIImage?, Error?, SDImageCacheType, URL?) -> Void#>)
        storyImage.sd_setImage(with: URL(string: newsItem.thumbnailURL!), placeholderImage: UIImage(named: "loading.png"))
    }
}
