//
//  RTableViewCell.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import AlamofireImage

class RTableViewCell: UITableViewCell {

    @IBOutlet var title:UILabel!
    @IBOutlet var imgv:UIImageView!
    @IBOutlet var desc:UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        desc.layer.borderWidth = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgv.af_cancelImageRequest()
        imgv.image = nil
    }
    
    class func verticalSpace()->CGFloat
    {
        return 0
    }

}
