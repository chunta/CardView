//
//  RCardViewController.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage

protocol RCardViewControllerDelegate {
    func didSelectCellAtIndex(index:Int)
}

class RCardViewController: UIViewController {

    private var heightMap:Dictionary<Int, CGSize> = Dictionary<Int, CGSize>()
    private var labelHeightMap:Dictionary<Int, CGFloat> = Dictionary<Int, CGFloat>()
    private var cardList:RCardModelList?
    private var tableView:UITableView!
    /*
    convenience init() {
        self.init(configuration: nil)
    }

    init() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped) // UITableView(frame: CGRect.zero, style)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        super.init(nibName: nil, bundle: nil)
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .grouped) // UITableView(frame: CGRect.zero, style)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.backgroundColor = UIColor.white
        self.tableView.separatorStyle = .none
        super.init(nibName: nil, bundle: nil)
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
}

extension RCardViewController: UITableViewDelegate, UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return cardList?.content.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (heightMap[indexPath.section] == nil)
        {
            let ratio:CGFloat = 600.0/400.0
            let h:CGFloat = tableView.frame.width / ratio
            let lh:CGFloat = labelHeightMap[indexPath.section] ?? 0
            return h + lh + RTableViewCell.verticalSpace()
            //return UITableView.automaticDimension
        }
        
        let size:CGSize = heightMap[indexPath.section]!
        let ratio:CGFloat = size.width / size.height
        let h:CGFloat = tableView.frame.width / ratio
        let lh:CGFloat = labelHeightMap[indexPath.section] ?? 0
        print("resize ", h)
        return h + lh + RTableViewCell.verticalSpace()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:RTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RTableViewCell") as! RTableViewCell
        cell.title.text = cardList?.content[indexPath.section].title.capitalizingFirstLetter()
        cell.title.sizeToFit()
        
        cell.desc.text = cardList?.content[indexPath.section].des
        cell.desc.sizeToFit()
        
        cell.layer.borderColor = UIColor.init(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 6
        
        self.labelHeightMap[indexPath.section] = CGFloat(ceil(Double(cell.title.bounds.size.height))) + CGFloat(ceil(Double(cell.desc.bounds.size.height)))
       
        let str:String = cardList!.content[indexPath.section].url
        let url:URL = URL(string:str)!
        let section:Int = indexPath.section
        let placeholder:UIImage = UIImage.init(named: "placeholder-600x400")!
        cell.imgv.sd_imageTransition = .fade
        cell.imgv.sd_setImage(with: url, placeholderImage: placeholder, options: .forceTransition, progress: nil) { (image, error, type, url) in
            if (error == nil && (image != nil)){
                print(image!.size, section)
                if (self.heightMap[section] == nil)
                {
                    self.heightMap[section] = image!.size
                    tableView.beginUpdates()
                    tableView.reloadRows(at: [IndexPath.init(row: 0, section: section)], with: .bottom)
                    tableView.endUpdates()
                }
            }
        }
      
        return cell
    }
}
