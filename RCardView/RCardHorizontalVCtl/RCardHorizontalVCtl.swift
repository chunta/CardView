//
//  RCardHorizontalVCtl.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage

class RCardHorizontalVCtl: UIViewController {

    private var collectionView:UICollectionView!
    private var configuration:RCardConfig!
    private var heightMap:Dictionary<Int, CGSize> = Dictionary<Int, CGSize>()
    private var cardList:RCardModelList?
    private var src:[Int] = [1,2,3,4,5,6]
    private var defaultSize:CGSize = CGSize.init(width: 10, height: 10)
    convenience init() {
        self.init(configuration: nil)
    }
    
    init(configuration: RCardConfig?) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = defaultSize
        flowLayout.scrollDirection = .horizontal
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.white
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(self.collectionView)
        let guide:UIView = self.view
        NSLayoutConstraint(item: self.collectionView, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: guide, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
    
        self.collectionView.register(UINib.init(nibName: "RCardColViewCell", bundle: nil), forCellWithReuseIdentifier: "RCardColViewCell")
    }
    
    func injectModel(_ cardModelList:RCardModelList)
    {
        cardList = cardModelList
        self.collectionView.reloadData()
    }
}

extension RCardHorizontalVCtl:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cardList?.content.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if (self.heightMap[indexPath.row] != nil)
        {
            let size:CGSize = heightMap[indexPath.row]!
            let ratio:CGFloat = size.width / size.height
            let w:CGFloat = self.view.frame.size.height * ratio
            return CGSize.init(width: w, height: self.view.frame.size.height)
        }
        let ratio:CGFloat = 600.0/400.0
        let w:CGFloat = self.view.frame.size.height * ratio
        return CGSize.init(width: w, height: self.view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RCardColViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"RCardColViewCell", for: indexPath) as! RCardColViewCell
        cell.title.text = cardList!.content[indexPath.row].title.capitalizingFirstLetter()
        let str:String = cardList!.content[indexPath.row].url
        let url:URL = URL(string:str)!
        let row:Int = indexPath.row
        let placeholder:UIImage = UIImage.init(named: "placeholder-600x400")!
        cell.imgv.sd_imageTransition = .fade
        cell.imgv.sd_setImage(with: url, placeholderImage: placeholder, options: .forceTransition, progress: nil) { (image, error, type, url) in
            if (error == nil && (image != nil)){
                print(image!.size, row)
                if (self.heightMap[row] == nil)
                {
                    self.heightMap[row] = image!.size
                    self.collectionView.collectionViewLayout.invalidateLayout()
                }
            }
        }
        return cell
    }
}
