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
    var arrRebels: [Rebel] = []
    
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
        DataService.shared.fetchRebels { (result) in
            DispatchQueue.main.async {
                switch result{
                    case .success(let rebels):
                        self.arrRebels = rebels
                        self.rebelTable.reloadData()
                case .failure(let error):
                        print(error)
                }
            }
        }
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
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRebels.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "rebelCellId", for: indexPath)
        let currentRebel = self.arrRebels[indexPath.row]
        cell.textLabel?.text = currentRebel.name
        cell.detailTextLabel?.text = currentRebel.birthYear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rebelCellId", for: indexPath)
        guard let name = cell.textLabel?.text else{
            print("Erro ao recuperar nome")
            return nil
        }

        let seenAction = UIContextualAction(style: .normal, title: "Seen"){ (action, view, completion) in
            DataService.shared.seenRebel(name: name) { (result) in
                DispatchQueue.main.async {
                    if(result){
                        print("Sucesso!")
                        self.showAlert(title: "Seen", message: "Sucesso!")
                    }
                    else{
                        print("Erro ao marcar como seen")
                    }
                }
            }
            completion(true)
        }
        
        seenAction.backgroundColor = .red
        let actionConfig = UISwipeActionsConfiguration(actions: [seenAction])
        return actionConfig
    }
}

