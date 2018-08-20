//
//  ToDoItem.swift
//  ToDo Realm
//
//  Created by Dawid Ramone on 19/08/2018.
//  Copyright © 2018 Dawid Czmyr. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class ToDoItem: Object {
    dynamic var task: String = ""
    dynamic var isDone: Bool = false
    
    convenience init(task: String, isDone: Bool) {
        self.init()
        self.task = task
        self.isDone = isDone
    }
}
