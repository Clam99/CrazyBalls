//
//  BlackHole.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class BlackHole: GameObject {
    let fixed:Bool
    
    init(fixed:Bool) {
        self.fixed = fixed
    }
    
    func getBP() -> UIBezierPath {
        bp = UIBezierPath(arcCenter: <#CGPoint#>, radius: <#CGFloat#>, startAngle: <#CGFloat#>, endAngle: <#CGFloat#>, clockwise: <#Bool#>))
    }
    
}