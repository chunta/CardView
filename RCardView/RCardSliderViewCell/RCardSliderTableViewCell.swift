//
//  RCardSliderTableViewCell.swift
//  RCardView
//
//  Created by nmi on 2019/2/12.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import CardSlidingView

class RCardSliderTableViewCell: UITableViewCell {
    
    private var slidingView:RCardSlidingView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse(){
        super.prepareForReuse()
        slidingView?.reset()
    }
    
    func injectSrc(_ src:[RCardSliderData], _ config:RCardSliderConfig){
        if (slidingView == nil){
            slidingView = RCardSlidingView.init(src, config)
            slidingView!.view.translatesAutoresizingMaskIntoConstraints = false
            slidingView!.view.backgroundColor = UIColor.white
            self.contentView.addSubview(slidingView!.view)
            NSLayoutConstraint(item: self.slidingView!.view, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.slidingView!.view, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.slidingView!.view, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
            NSLayoutConstraint(item: self.slidingView!.view, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        }
        
    }
}

