//
//  BottomBarItem.swift
//  AnimBless
//
//  Created by iBlessme on 05.05.2022.
//

import Foundation
import SwiftUI

struct BottombarItem{
    let icon: String
    let title: String
    let color: Color
    
    init(icon: String, title: String, color: Color){
        self.icon = icon
        self.title = title
        self.color = color
    }
}
