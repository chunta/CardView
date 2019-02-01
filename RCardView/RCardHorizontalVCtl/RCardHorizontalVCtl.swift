//
//  RCardHorizontalVCtl.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import UIKit

class RCardHorizontalVCtl: UIViewController {

    private var collectionView:UICollectionView!
    private var configuration:RCardConfig!
    private var heightMap:Dictionary<Int, CGSize> = Dictionary<Int, CGSize>()
    private var cardList:RCardModelList?
    
    convenience init() {
        self.init(configuration: nil)
    }
    
    init(configuration: RCardConfig?) {
        self.configuration = configuration

        let flowLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 200)
        self.collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView.backgroundColor = UIColor.purple
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.layer.borderWidth = 2
        
        super.init(nibName: nil, bundle: nil)
        
        //self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.collectionView)
        let guide:UIView = self.view
        NSLayoutConstraint(item: self.collectionView, attribute: .leading, relatedBy: .equal, toItem: guide, attribute:.leading, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .trailing, relatedBy: .equal, toItem: guide, attribute:.trailing, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .top, relatedBy: .equal, toItem: guide, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self.collectionView, attribute: .bottom, relatedBy: .equal, toItem: guide, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
    
        self.collectionView.register(UINib.init(nibName: "RCardColViewCell", bundle: nil), forCellWithReuseIdentifier: "RCardColViewCell")
    }
}

extension RCardHorizontalVCtl:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return cardList?.content.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RCardColViewCell = collectionView.dequeueReusableCell(withReuseIdentifier:"RCardColViewCell", for: indexPath) as! RCardColViewCell
        cell.title.text = cardList!.content[indexPath.row].title
        return cell
    }
}
