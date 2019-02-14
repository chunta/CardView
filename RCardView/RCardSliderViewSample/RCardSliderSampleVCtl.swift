//
//  RCardSliderSampleVCtl.swift
//  RCardView
//
//  Created by nmi on 2019/2/12.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit

class RCardSliderSampleVCtl: UIViewController {

    private var tableView:UITableView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView.init()
        //tableView.backgroundColor = UIColor.red
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        
        tableView.register(UINib.init(nibName: "RCardSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "RCardSliderTableViewCell")
    }
}

extension RCardSliderSampleVCtl: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RCardSliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RCardSliderTableViewCell") as! RCardSliderTableViewCell
        
        let src:[RCardSliderData] = [ RCardSliderData.init(title: "The Untold Secret To Mastering ALITA In Just 3 Days.3 Simple Tips For Using ALITA To Get Ahead Your Competition", des: "Hello World", url: "https://dl.dropboxusercontent.com/s/pue5p4tkw0f3xq1/haifsa-rafique-110898-unsplash-small.jpg"),
                                      RCardSliderData.init(title: "Why My ALITA Is Better Than Yours", des: "Hello Friend", url: "https://dl.dropboxusercontent.com/s/r1blgs7eue99y5x/on-the-road-6-1384796.jpg"),
                                      RCardSliderData.init(title: "How To Earn $398/Day Using ALITA", des: "Hello Miss", url: "https://dl.dropboxusercontent.com/s/kalnied3mo0bu2k/pickupimage.jpg")]
        let conf:RCardSliderConfig = RCardSliderConfig.init(indicator_gap: 6, indicator_botmargin: 20,
                                                            indicator_rlmargin: 20, indicator_color: UIColor.white,
                                                            indicator_cornerradius: 3, indicator_height: 6,
                                                            indicator_slideduration: 4, indicator_resetdelay: 0.7,
                                                            indicator_interruptable: true)
        cell.injectSrc(src, conf)
        cell.layer.borderWidth = 1
        return cell
    }
}
