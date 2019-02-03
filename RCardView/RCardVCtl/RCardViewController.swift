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
import SDWebImage

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
    private var labelHeightMap:Dictionary<Int, CGFloat> = Dictionary<Int, CGFloat>()
    private var cardList:RCardModelList?
    private var tableView:UITableView!
    convenience init() {
        self.init(configuration: nil)
    }

    init(configuration: RCardConfig?) {
        self.configuration = configuration
        self.tableView = UITableView(frame: CGRect.zero)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
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
    
    private func clearImageFromCache(mYourImageURL: String) {
        let URL = NSURL(string: mYourImageURL)!
        let mURLRequest = NSURLRequest(url: URL as URL)
        _ = URLRequest(url: URL as URL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData)
        
        let imageDownloader = UIImageView.af_sharedImageDownloader
        _ = imageDownloader.imageCache?.removeImage(for: mURLRequest as URLRequest, withIdentifier: nil)
    }
    
    func injectModel(_ cardModelList:RCardModelList)
    {
        cardList = cardModelList
        /*
        for cardindex in 0 ... cardList!.content.count-1 {
            let card:RCardModel = cardList!.content[cardindex]
            clearImageFromCache(mYourImageURL: card.url)
        }
        */
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
        let lh:CGFloat = labelHeightMap[indexPath.row] ?? 0
        print("resize ", h)
        return h + lh
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RTableViewCell") as! RTableViewCell
        cell.title.text = cardList?.content[indexPath.row].title
        cell.title.sizeToFit()
        
        cell.desc.text = cardList?.content[indexPath.row].des
        cell.desc.sizeToFit()
        
        self.labelHeightMap[indexPath.row] = CGFloat(ceil(Double(cell.title.bounds.size.height))) + CGFloat(ceil(Double(cell.desc.bounds.size.height)))
        print(self.labelHeightMap[indexPath.row]!, indexPath.row )
        
        let str:String = cardList!.content[indexPath.row].url
        let url:URL = URL(string:str)!
        /*
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
        */
        let row:Int = indexPath.row
        cell.imgv.sd_setImage(with: url, placeholderImage: nil, options: .forceTransition, progress: nil) { (image, error, type, url) in
            if (error == nil && (image != nil)){
                
                print(image!.size, row)
                if (self.heightMap[row] == nil)
                {
                    self.heightMap[row] = image!.size
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .bottom)
                    tableView.endUpdates()
                }
            }
        }
      
        return cell
    }
}
