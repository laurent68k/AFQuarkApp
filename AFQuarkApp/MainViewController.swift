//
//  MainViewController.swift
//  AFQuarkApp
//
//  Created by Laurent Favard on 30/03/2019.
//  Copyright © 2019 Laurent Favard. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell!
        
        if indexPath.row == 0 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "alertCellType", for: indexPath)
            cell.textLabel?.text = "Alert box"
        }
        else if indexPath.row == 1 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: "cameraCellType", for: indexPath)
            cell.textLabel?.text = "Camera and iCloud"
        }
        else {
            
        }
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }


}
