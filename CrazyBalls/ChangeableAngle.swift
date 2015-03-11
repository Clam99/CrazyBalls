//
//  ChangeableAngle.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation

protocol ChangeableAngle {
    var angle:Double {get}
    var points:(Vector, Vector) {get}
    
    func updatePoints()
}