//
//  RCardSliderSampleVCtl.swift
//  RCardView
//
//  Created by nmi on 2019/2/12.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import CardSlidingView

class RCardSliderSampleVCtl: UIViewController {

    private var tableView:UITableView!
    private var src:[Int:([RCardSliderData], RCardSliderConfig)] = [:]
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView.init()

        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self

        NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: tableView, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1.0, constant: 0.0).isActive = true
        
        tableView.register(UINib.init(nibName: "RCardSliderTableViewCell", bundle: nil), forCellReuseIdentifier: "RCardSliderTableViewCell")
        tableView.register(UINib.init(nibName: "RCardSliderSimpleTableViewCell", bundle: nil), forCellReuseIdentifier: "RCardSliderSimpleTableViewCell")
        
        let src01:[RCardSliderData] = [ RCardSliderData.init(title: "The Untold Secret To Mastering ALITA In Just 3 Days.3 Simple Tips For Using ALITA To Get Ahead Your Competition", des: "Hello World", url: "https://dl.dropboxusercontent.com/s/pue5p4tkw0f3xq1/haifsa-rafique-110898-unsplash-small.jpg"),
                                      RCardSliderData.init(title: "Why My ALITA Is Better Than Yours", des: "Hello Friend", url: "https://dl.dropboxusercontent.com/s/r1blgs7eue99y5x/on-the-road-6-1384796.jpg"),
                                      RCardSliderData.init(title: "How To Earn $398/Day Using ALITA", des: "Hello Miss", url: "https://dl.dropboxusercontent.com/s/kalnied3mo0bu2k/pickupimage.jpg")]
        let conf01:RCardSliderConfig = RCardSliderConfig.init(gap: 6, botmargin: 20,
                                                            rlmargin: 20, color: UIColor.white,
                                                            titlecolor: UIColor.white,
                                                            descolor: UIColor.white,
                                                            cornerradius: 0, height: 5,
                                                            slideduration: 2, resetdelay: 0.7,
                                                            interruptable: true, placeholder: nil, textalignment: .Bottom,
                                                            titlehighlitcolor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6),
                                                            deshighlitcolor: UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.7))
        src[0] = (src01, conf01)
        
        let src02:[RCardSliderData] = [ RCardSliderData.init(title: "The Secret of Successful EDO",
                                                             des: "EDO Doesn't Have To Be Hard. Read These 9 Tricks Go Get A Head Start.",
                                                             url: "https://dl.dropboxusercontent.com/s/z0e3qo48yy5x2my/betterdays.jpg"),
                                        RCardSliderData.init(title: "Got Stuck? Try These Tips To Streamline Your EDO",
                                                             des: "10 Essential Strategies To EDO. 3 Reasons Why Having An Excellent EDO Isn't Enough",
                                                             url: "https://dl.dropboxusercontent.com/s/17gaam75mp438c1/jazmin-quaynor-105210-unsplash-small.jpg"),
                                        RCardSliderData.init(title: "Fascinating EDO Tactics That Can Help Your Business Grow",
                                                             des: "10 Small Changes That Will Have A Huge Impact On Your EDO",
                                                             url: "https://dl.dropboxusercontent.com/s/06croipyfddqgrn/john-towner-154060-unsplash-small.jpg"),
                                        RCardSliderData.init(title: "You Can Thank Us Later - 3 Reasons To Stop Thinking About EDO",
                                                             des: "The Most Common Mistakes People Make With EDO",
                                                             url: "https://dl.dropboxusercontent.com/s/7cveao466x0mfqg/dayne-topkin-40038-unsplash-small.jpg"),
                                        RCardSliderData.init(title: "Some People Excel At EDO And Some Don't - Which One Are You? 7 Ways To Keep Your EDO Growing Without Burning The Midnight Oil",
                                                             des: "The Most Common EDO Debate Isn't As Simple As You May Think",
                                                             url: "https://dl.dropboxusercontent.com/s/sek3zy7k9sz8u98/karla-caloca-416107-unsplash-small.jpg")]
        let conf02:RCardSliderConfig = RCardSliderConfig.init(gap: 6, botmargin: 20,
                                                              rlmargin: 20, color: UIColor.white,
                                                              titlecolor: UIColor.white,
                                                              descolor: UIColor.black,
                                                              cornerradius: 2, height: 4,
                                                              slideduration: 2, resetdelay: 0.7,
                                                              interruptable: true, placeholder: nil, textalignment: .Bottom,
                                                              titlehighlitcolor: UIColor.clear,
                                                              deshighlitcolor: UIColor.init(red: 0.5, green: 1, blue: 0.4, alpha: 0.1))
        src[1] = (src02, conf02)

    }
}

extension RCardSliderSampleVCtl: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row%3 == 0) {
            let cell:RCardSliderTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RCardSliderTableViewCell") as! RCardSliderTableViewCell
            let thesrc:([RCardSliderData],RCardSliderConfig) = src[indexPath.row%2]!
            cell.injectSrc(thesrc.0, thesrc.1)
            
            cell.layer.borderWidth = 1
            return cell
        }
        
        let cell:RCardSliderSimpleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RCardSliderSimpleTableViewCell") as! RCardSliderSimpleTableViewCell
        cell.textLabel?.text = String(format: "%d", indexPath.row)
        cell.textLabel?.textAlignment = .center
        cell.layer.borderWidth = 1
        return cell
    }
}
