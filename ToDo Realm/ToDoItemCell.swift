//
//  ToDoItemCell.swift
//  ToDo Realm
//
//  Created by Dawid Ramone on 19/08/2018.
//  Copyright © 2018 Dawid Czmyr. All rights reserved.
//

import UIKit

class ToDoItemCell: UITableViewCell {
    
    @IBOutlet weak var toDoItemLabel: UILabel!
    @IBOutlet weak var doneImageView: UIImageView!
    
    func configureCell(with toDoItem: ToDoItem) {
        toDoItemLabel.text = toDoItem.task
        let isDone = toDoItem.isDone
        
        if isDone  == false {
            doneImageView.image = #imageLiteral(resourceName: "undone")
        } else {
            doneImageView.image = #imageLiteral(resourceName: "done")
        }
    }
}
