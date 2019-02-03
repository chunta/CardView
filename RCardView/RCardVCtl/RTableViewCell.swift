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
        title.backgroundColor = UIColor.red
        desc.backgroundColor = UIColor.red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgv.sd_cancelCurrentImageLoad()
        imgv.image = nil
    }
    
    
    
    class func verticalSpace()->CGFloat
    {
        return 0
    }

}
