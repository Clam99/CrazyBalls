//
//  ViewController.swift
//  HardThing
//
//  Created by Sam Noyes on 3/7/15.
//  Copyright (c) 2015 Sam Noyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let v = View(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height));
        view.addSubview(v);
        view.setNeedsDisplay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

