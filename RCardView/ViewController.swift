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
    var cardSliderSample:RCardSliderSampleVCtl!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        SDImageCache.shared().clearMemory()
        SDImageCache.shared().clearDisk()
        SDWebImageManager.shared().imageDownloader?.executionOrder = .lifoExecutionOrder
        SDWebImageManager.shared().imageDownloader?.downloadTimeout = 40
        
        let guide:UILayoutGuide = self.view.safeAreaLayoutGuide
        
        /*
        cardHorizontalView = RCardHorizontalVCtl.init()
        cardHorizontalView.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardHorizontalView.view)
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardHorizontalView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.11, constant: 0.0).isActive = true
        
        cardView = RCardViewController.init()
        self.view.addSubview(cardView.view)
        cardView.view.layer.borderWidth = 2
        cardView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: cardView.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: -10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .top, relatedBy: .equal, toItem: cardHorizontalView.view, attribute: .bottom, multiplier: 1.0, constant: 10.0).isActive = true
        NSLayoutConstraint(item: cardView.view, attribute: .height, relatedBy: .equal, toItem: guide, attribute: .height, multiplier: 0.3, constant: 0.0).isActive = true
        */
        
        cardSliderSample = RCardSliderSampleVCtl.init()
        self.view.addSubview(cardSliderSample.view)
        cardSliderSample.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: cardSliderSample.view, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: cardSliderSample.view, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: cardSliderSample.view, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: cardSliderSample.view, attribute: .bottom, relatedBy: .equal, toItem: guide, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        /*
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
        */
        //---------------------
    }


}

