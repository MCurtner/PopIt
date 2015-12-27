//
//  Extensions.swift
//  PopIt
//
//  Created by Matthew Curtner on 12/12/15.
//  Copyright © 2015 Matthew Curtner. All rights reserved.
//

import Foundation
import SpriteKit

extension CGFloat {
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF) * (max - min) + min
    }
}