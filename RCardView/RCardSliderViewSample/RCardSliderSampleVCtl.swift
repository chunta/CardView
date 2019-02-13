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
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:RCardSliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RCardSliderTableViewCell") as! RCardSliderTableViewCell
        
        let src:[RCardSliderData] = [ RCardSliderData.init(title: "134", des: "Hello World", url: "http://abc.com"),
                                      RCardSliderData.init(title: "567", des: "Hello Friend", url: "http://abc.com"),
                                      RCardSliderData.init(title: "900", des: "Hello Miss", url: "http://abc.com")]
        let conf:RCardSliderConfig = RCardSliderConfig.init(indicator_gap: 6, indicator_botmargin: 20, indicator_rlmargin: 20, indicator_color: UIColor.purple, indicator_cornerradius: 5, indicator_height: 10, indicator_slideduration:2, indicator_resetdelay: 0.14)
        cell.injectSrc(src, conf)
        cell.layer.borderWidth = 1
        return cell
    }
}
