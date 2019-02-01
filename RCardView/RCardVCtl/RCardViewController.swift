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
        self.tableView.reloadData()
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
        
        /*
        if (self.configuration.direction == .Horizontal)
        {
            if (cell.contentView.transform==CGAffineTransform.identity)
            {
                let xorigin:Int = Int((cell.bounds.size.width - cell.bounds.size.height) / 2.0);
                let yorigin:Int = Int((cell.bounds.size.height - cell.bounds.size.width) / 2.0);
                cell.contentView.frame = CGRect.init(x: xorigin, y: yorigin, width: Int(cell.bounds.size.height), height: Int(cell.bounds.size.width))
                cell.contentView.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat.pi/2.0));
            }
        }
        */
                
        let row:Int = indexPath.row
        Alamofire.request((cardList?.content[indexPath.row].url)!).responseImage { response in
            if let image = response.result.value {
                cell.imgv.image = image
                if (self.heightMap[row] == nil)
                {
                    self.heightMap[row] = image.size
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [IndexPath.init(row: row, section: 0)], with: .none)
                    tableView.endUpdates()
                }
            }
        }
        
        return cell
    }
}
