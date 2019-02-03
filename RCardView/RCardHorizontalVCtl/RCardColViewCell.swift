//
//  RCardColViewCell.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit

class RCardColViewCell: UICollectionViewCell {

    @IBOutlet var title:UILabel!
    @IBOutlet var imgv:UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgv.af_cancelImageRequest()
        imgv.image = nil
    }

}
