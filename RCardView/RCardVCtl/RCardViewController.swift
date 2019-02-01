//
//  RCardViewController.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

enum RCardLayoutDirection {
    case Vertical
    case Horizontal
}

enum RCardLeftTitleVerticalGap {
    case GapDefault
    case GapSmall
    case GapMedium
    case GapLarge
}

enum RCardLeftTitleHorizontalGap {
    case GapDefault
    case GapSmall
    case GapMedium
    case GapLarge
}

enum RCardSwipeAnimation {
    case None
    case ShrinkToBig
}

struct RCardConfig
{
    var direction:RCardLayoutDirection = .Vertical
    var lefttitleVerGap:RCardLeftTitleVerticalGap = .GapDefault
    var lefttitleHorGap:RCardLeftTitleHorizontalGap = .GapDefault
    var fullscreenImage:Bool = false
    var swipeAnimation:RCardSwipeAnimation = .None
}

protocol RCardViewControllerDelegate {
    func didSelectCellAtIndex(index:Int)
}

class RCardViewController: UIViewController {

    private var configuration:RCardConfig!
    private var heightMap:Dictionary<Int, CGSize> = Dictionary<Int, CGSize>()
    private var cardList:RCardModelList?
    private var tableView:UITableView!
    convenience init() {
        self.init(configuration: nil)
    }

    init(configuration: RCardConfig?) {
        self.configuration = configuration
        self.tableView = UITableView(frame: CGRect.zero)
        self.tableView.backgroundColor = UIColor.yellow
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.layer.borderWidth = 2

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        let guide:UIView = self.view
        NSLayoutConstraint(item: self.tableView, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: guide, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        self.tableView.register(UINib.init(nibName: "RTableViewCell", bundle: nil), forCellReuseIdentifier: "RTableViewCell")
        self.tableView.estimatedRowHeight = 66
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func injectModel(_ cardModelList:RCardModelList)
    {
        cardList = cardModelList
        
        for cardindex in 0 ... cardList!.content.count-1 {
            let card:RCardModel = cardList!.content[cardindex]
            
            let URLRequest = NSURLRequest(url: URL(string: card.url)!)
            
            let imageDownloader = UIImageView.af_sharedImageDownloader
            
            // Clear the URLRequest from the in-memory cache
            //imageDownloader.imageCache?.removeImageForRequest(URLRequest, withAdditionalIdentifier: nil)
            
            // Clear the URLRequest from the on-disk cache
            imageDownloader.sessionManager.session.configuration.urlCache?.removeCachedResponse(for: URLRequest as URLRequest)
        }
        self.tableView.reloadData()
    }
}

extension RCardViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList?.content.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (heightMap[indexPath.row] == nil)
        {
            return UITableView.automaticDimension
        }
        
        let size:CGSize = heightMap[indexPath.row]!
        let ratio:CGFloat = size.width / size.height
        let h:CGFloat = tableView.frame.width / ratio
        let lh:CGFloat = 21
        return h + lh
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RTableViewCell") as! RTableViewCell
        cell.title.text = cardList?.content[indexPath.row].title

        let str:String = cardList!.content[indexPath.row].url
        let url:URL = URL(string:str)!
        let closureName = { (image : DataResponse<UIImage>) -> Void in
            let indexpath:IndexPath? = self.tableView.indexPath(for: cell) ?? nil
            if (indexpath != nil && self.heightMap[indexpath!.row] == nil)
            {
                self.heightMap[indexpath!.row] = image.result.value?.size
                tableView.beginUpdates()
                tableView.reloadRows(at: [IndexPath.init(row: indexpath!.row, section: 0)], with: .bottom)
                tableView.endUpdates()
            }
        }
        cell.imgv.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.4), runImageTransitionIfCached: true, completion: closureName)
        return cell
    }
}



/*
 func refreshOrientation()
 {
 if (self.tableView != nil)
 {
 self.tableView.transform = CGAffineTransform.identity
 self.tableView.frame = CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
 let xorgin:Int = Int((self.view.bounds.size.width - self.view.bounds.size.height) / 2.0)
 let yorgin:Int = Int((self.view.bounds.size.height - self.view.bounds.size.width) / 2.0)
 self.tableView.frame = CGRect.init(x: xorgin, y: yorgin, width: Int(self.view.bounds.size.height), height: Int(self.view.bounds.size.width))
 self.tableView.transform = CGAffineTransform.init(rotationAngle: CGFloat(-1*CGFloat.pi / 2))
 }
 }
 */
