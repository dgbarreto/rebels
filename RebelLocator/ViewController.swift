//
//  ViewController.swift
//  RebelLocator
//
//  Created by Danilo Barreto on 22/05/21.
//  Copyright © 2021 Danilo Barreto. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    @IBOutlet weak var rebelTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "rebelCellId", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let seenAction = UIContextualAction(style: .normal, title: "Seen"){ (action, view, completion) in
            completion(true)
        }
        
        seenAction.backgroundColor = .red
        let actionConfig = UISwipeActionsConfiguration(actions: [seenAction])
        return actionConfig
    }
}

