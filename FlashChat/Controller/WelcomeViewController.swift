//
//  ViewController.swift
//  FlashChat
//
//  Created by Alexandre Robaert on 01/08/20.
//  Copyright © 2020 Alexandre Robaert. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleClTypingLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleClTypingLabel.text = K.appName
    }
}

