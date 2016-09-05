//
//  ViewController.swift
//  Example
//
//  Created by Diego Ernst on 9/5/16.
//  Copyright © 2016 Diego Ernst. All rights reserved.
//

import UIKit
import GenericPasswordRow
import Eureka

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section()
            <<< GenericPasswordRow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
