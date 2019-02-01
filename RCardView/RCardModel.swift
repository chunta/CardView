//
//  RCardModel.swift
//  RCardView
//
//  Created by nmi on 2019/2/1.
//  Copyright © 2019 nmi. All rights reserved.
//

import Foundation

struct RCardModel:Codable
{
    let id:Int
    let title:String!
    let url:String!
    let des:String!
}

struct RCardModelList:Codable
{
    let content:[RCardModel]!
}
