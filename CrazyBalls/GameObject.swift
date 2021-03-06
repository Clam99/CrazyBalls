//
//  GameObject.swift
//  HardThing
//
//  Created by Sam Noyes on 3/9/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import Foundation
import UIKit

protocol GameObject {
    var fixed:Bool {get}
    var done:Bool? {get set}
    func getBP() -> UIBezierPath
}