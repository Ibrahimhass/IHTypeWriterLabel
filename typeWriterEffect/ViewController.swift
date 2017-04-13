//
//  ViewController.swift
//  typeWriterEffect
//
//  Created by Md Ibrahim Hassan on 14/04/17.
//  Copyright © 2017 Md Ibrahim Hassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
          let labelRef = IHTypeWriterLabel()
    @IBAction func start(_ sender: Any) {
        labelRef.resumeAnimation()
    }
    
    
    @IBAction func stop(_ sender: Any) {
        labelRef.pauseAnimation()
    }
}

