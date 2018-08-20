//
//  ViewController.swift
//  ToDo Realm
//
//  Created by Dawid Ramone on 19/08/2018.
//  Copyright © 2018 Dawid Czmyr. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let cellID = "toDoItemCell"
    var toDoItems: Results<ToDoItem>!
    var notificationToken: NotificationToken?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let realm = RealmService.shared.realm
        toDoItems = realm.objects(ToDoItem.self)
        
        notificationToken = realm.observe { (notification, realm) in
            self.tableView.reloadData()
        }
        RealmService.shared.observeRealmErrors(in: self) { (error) in
            // handle error
            print(error ?? "no error detected")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }
    
    @IBAction func addToDoItemButton(_ sender: UIBarButtonItem) {
        AlertService.addAlert(in: self) { (itemToDo) in
            let toDoItem = ToDoItem(task: itemToDo, isDone: false)
            RealmService.shared.create(toDoItem)
        }
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? ToDoItemCell else { return UITableViewCell() }
        let toDoItem = toDoItems[indexPath.row]
        cell.configureCell(with: toDoItem)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoItems[indexPath.row]
        AlertService.updateAlert(in: self, toDoItem: item) { (line, isDone) in
            let dictionary: [String: Any?] = ["task": line,
                                              "isDone": isDone]
            RealmService.shared.update(item, with: dictionary)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let toDoItem = toDoItems[indexPath.row]
        RealmService.shared.delete(toDoItem)
    }
}














