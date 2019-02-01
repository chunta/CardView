//
//  ViewController.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    var cardView:RCardViewController!
    var cardHorizontalView:RCardHorizontalVCtl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let config:RCardConfig = RCardConfig()
        //config.direction = .Horizontal
        cardView = RCardViewController.init(configuration: config)
        self.view.addSubview(cardView.view)
        cardView.view.translatesAutoresizingMaskIntoConstraints = false
        let guide:UILayoutGuide = self.view.safeAreaLayoutGuide
        NSLayoutConstraint(item: cardView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.9, constant: 0.0).isActive = true
        
        /*
        cardHorizontalView = RCardHorizontalVCtl.init(configuration: config)
        cardHorizontalView.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardHorizontalView.view)
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .top, relatedBy: .equal, toItem: cardView.view, attribute: .bottom, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.5, constant: 0.0).isActive = true
        */
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        Alamofire.request("https://dl.dropboxusercontent.com/s/r7vzr20i9735a37/magazine.json", headers: headers).responseJSON { response in
            if (response.result.isSuccess)
            {
                if (response.data != nil)
                {
                    let str = String(data: response.data!, encoding: .utf8)!
                    print(str)
                    let decoder = JSONDecoder()
                    let cardList:RCardModelList = try! decoder.decode(RCardModelList.self, from: response.data!)
                    print(cardList)
                    self.cardView.injectModel(cardList)
                }
                
            }
        }
        //---------------------
    }


}

