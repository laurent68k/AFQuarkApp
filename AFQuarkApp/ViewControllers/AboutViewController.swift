//
//  AboutViewController.swift
//  AFQuarkApp
//
//  Created by Laurent Favard on 06/04/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit
import AFQuark

class AboutViewController: AFAboutViewController {

    @IBOutlet weak var versionTextLabel: UILabel!
    @IBOutlet weak var rateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Just connect my objects to the ancestor's properties
        super.versionLabel = self.versionTextLabel
        super.giveOpinionButton = self.rateButton
    }
}
