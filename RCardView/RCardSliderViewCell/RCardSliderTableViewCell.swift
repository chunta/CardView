//
//  RCardSliderTableViewCell.swift
//  RCardView
//
//  Created by nmi on 2019/2/12.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
struct RCardSliderData
{
    
}

struct RCardSliderConfig {
    let indicator_gap:CGFloat
    let indicator_top:CGFloat
    let indicator_rlmargin:CGFloat
    let indicator_color:CGColor
    let indicator_cornerradius:CGFloat
}

class RCardSliderTableViewCell: UITableViewCell {

    private var src:[RCardSliderData]
    private var config:RCardSliderConfig
    init(_ src:[RCardSliderData], config:RCardSliderConfig) {
        super.init()
        self.src = src
        self.config = config
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
