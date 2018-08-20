//
//  AlertService.swift
//  Pick Up Lines Proto
//
//  Created by Kyle Lee on 10/14/17.
//  Copyright © 2017 Kilo Loco. All rights reserved.
//

import UIKit

class AlertService {
    
    private init() {}
    
    static func addAlert(in vc: UIViewController,
                         completion: @escaping (String) -> Void) {
        
        let alert = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Enter Item To Do"
        }

        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text else { return }
            completion(line)
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(action)
        alert.addAction(dismissAction)
        vc.present(alert, animated: true)
    }
    
    static func updateAlert(in vc: UIViewController,
                            toDoItem: ToDoItem,
                            completion: @escaping (String, Bool) -> Void) {
        
        let alert = UIAlertController(title: "List:", message: nil, preferredStyle: .alert)
        alert.addTextField { (lineTF) in
            lineTF.placeholder = "Update"
            lineTF.text = toDoItem.task
        }
    
        let action = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text else { return }
                let isDone = toDoItem.isDone
        
            completion(line, isDone)
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        let doneMark = UIAlertAction(title: "Mark as Done", style: .default) { (_) in
            guard let line = alert.textFields?.first?.text else { return }
            let isDone = true
            completion(line, isDone)
        }
        
        alert.addAction(action)
        alert.addAction(dismissAction)
        alert.addAction(doneMark)
        vc.present(alert, animated: true)
    }
}


