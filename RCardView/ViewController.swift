//
//  ViewController.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {

    var cardView:RCardViewController!
    var cardHorizontalView:RCardHorizontalVCtl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        
        let guide:UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let config:RCardConfig = RCardConfig()
        
        cardHorizontalView = RCardHorizontalVCtl.init(configuration: config)
        cardHorizontalView.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardHorizontalView.view)
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.2, constant: 0.0).isActive = true
        
        cardView = RCardViewController.init(configuration: config)
        self.view.addSubview(cardView.view)
        cardView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: cardView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .top, relatedBy: .equal, toItem: cardHorizontalView.view, attribute: .bottom, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.7, constant: 0.0).isActive = true
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        Alamofire.request("https://dl.dropboxusercontent.com/s/r7vzr20i9735a37/magazine.json", headers: headers).responseJSON { response in
            if (response.result.isSuccess)
            {
                if (response.data != nil)
                {
                    let decoder = JSONDecoder()
                    let cardList:RCardModelList = try! decoder.decode(RCardModelList.self, from: response.data!)
                    self.cardView.injectModel(cardList)
                }
                
            }
        }
        
        Alamofire.request("https://dl.dropboxusercontent.com/s/iej0ijakvj12gpp/magazine2.json", headers: headers).responseJSON { response in
            if (response.result.isSuccess)
            {
                if (response.data != nil)
                {
                    let decoder = JSONDecoder()
                    let cardList:RCardModelList = try! decoder.decode(RCardModelList.self, from: response.data!)
                    self.cardHorizontalView.injectModel(cardList)
                }
                
            }
        }
        //---------------------
    }


}

