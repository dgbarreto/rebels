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
        
//        let rebelPayload = Rebel(name: "Rey", bioURL: nil, birthYear: "BY178")
//
//        do{
//            let rebelData = try JSONEncoder().encode(rebelPayload)
//            let stringData = String(data: rebelData, encoding: .utf8)
//            print(stringData)
//        }catch {
//            print("Erro no encoding")
//        }
//
//        DataService.shared.fetchRebels { (result) in
//            switch result{
//                case .success(let rebels):
//                    for rebel in rebels {
//                        print("\(rebel.name)\n")
//                        print("\(rebel.bioURL?.absoluteString)\n")
//                        print("\(rebel.birthYear)\n")
//                    }
//            case .failure(let error):
//                    print(error)
//            }
//        }
    }
    
    @IBAction func createNewAlert(_ sender: UIButton){
        let alert = Alert(when: Date(), who: "Rey")
        DataService.shared.createNewAlert(alert: alert) { (result) in
            switch result{
                case .success(let output):
                    print(output)
                case .failure(let error):
                    print(error)
            }
        }
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
            DataService.shared.seenRebel(name: "Rey") { (result) in
                if(result){
                    print("Rey marcada como 'seen'")
                }
                else{
                    print("Erro ao marcar como seen")
                }
            }
            completion(true)
        }
        
        seenAction.backgroundColor = .red
        let actionConfig = UISwipeActionsConfiguration(actions: [seenAction])
        return actionConfig
    }
}

