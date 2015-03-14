//
//  LevelLayout.swift
//  CrazyBalls
//
//  Created by Sam Noyes on 3/13/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation

class LevelLayout {
    var surfaces:[Surface]
    var blackHoles:[BlackHole]
    let numPositionable:[Int] = [Int]()
    
    init(s:[Surface], b:[BlackHole], movingBlackHoles:Int, movingSprings:Int, movingSurfaces:Int) {
        surfaces = s
        blackHoles = b
        numPositionable[objectKeys.blackHole.rawValue] = movingBlackHoles
        numPositionable[objectKeys.spring.rawValue] = movingSprings
        numPositionable[objectKeys.surface.rawValue] = movingSurfaces
    }
}

enum objectKeys:Int {
    case surface = 0
    case blackHole = 1
    case spring = 2
}