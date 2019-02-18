//
//  Extension.swift
//  RCardView
//
//  Created by Cindy on 2019/2/3.
//  Copyright © 2019年 nmi. All rights reserved.
//

import Foundation

extension String {
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
