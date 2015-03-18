//
//  LevelLayout.swift
//  CrazyBalls
//
//  Created by Sam Noyes on 3/13/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

class LevelLayout {
    var fixedObjects:[GameObject]
    let numPositionable:[Int] = [Int]()
    let goal:CGPoint
    var goalRadius:Double = 25.0
    
    init(g:[GameObject], movingBlackHoles:Int, movingSprings:Int, movingSurfaces:Int, goal:CGPoint) {
        fixedObjects = g
        numPositionable.insert(movingBlackHoles, atIndex: min(numPositionable.count, objectKeys.blackHole.rawValue))
        numPositionable.insert(movingSprings, atIndex: min(numPositionable.count, objectKeys.spring.rawValue))
        numPositionable.insert(movingSurfaces, atIndex: min(numPositionable.count, objectKeys.surface.rawValue))
//        numPositionable[objectKeys.blackHole.rawValue] = movingBlackHoles
//        numPositionable[objectKeys.spring.rawValue] = movingSprings
//        numPositionable[objectKeys.surface.rawValue] = movingSurfaces
        self.goal = goal
    }
}

enum objectKeys:Int {
    case surface
    case blackHole
    case spring
    case keysCount
}