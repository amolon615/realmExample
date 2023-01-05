//
//  RealmManager.swift
//  realmExample
//
//  Created by Artem on 05/01/2023.
//

import Foundation
import RealmSwift


class RealmManager: ObservableObject {
   
    
    
    private(set) var localRealm: Realm?
    
    @Published var tasks: [Task] = []
    
    
    init(){
        openRealm()
        getTasks()
    }
    
    
    func openRealm(){
        
        
        do {
            let config = Realm.Configuration(schemaVersion: 1)
            
            Realm.Configuration.defaultConfiguration = config
            
            localRealm = try Realm() 
            
        } catch let error {
            print("error opening realm. \(error.localizedDescription)")
        }
    }
    
    func addTask(taskTitle: String){
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newTask = Task(value: ["title" : taskTitle, "completed" : false])
                    localRealm.add(newTask)
                    getTasks()
                    print("added new task to realm \(newTask)")
                    
                }
            } catch {
                print("error adding task to realm")
            }
        }
    }
    
    func getTasks(){
        if let localRealm = localRealm {
           let allTasks =  localRealm.objects(Task.self).sorted(byKeyPath: "completed")
                tasks = []
                allTasks.forEach {task in
              tasks.append(task)
          }
        }
    }
    
    func updateTask(id: ObjectId, completed: Bool){
        if let localRealm = localRealm {
            do {
               let taskToUpdate = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                guard !taskToUpdate.isEmpty else { return }
                
                try localRealm.write {
                    taskToUpdate[0].completed = completed
                    getTasks()
                    print("updated task with id \(id)! Completed status \(completed)")
                    
                }
                
            } catch let error{
                print("error updating task \(id) to Realm \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTask(id: ObjectId){
        if let localRealm = localRealm {
            
            do {
                let taskToDelete = localRealm.objects(Task.self).filter(NSPredicate(format: "id == %@", id))
                 guard !taskToDelete.isEmpty else { return }
                try localRealm.write {
                    localRealm.delete(taskToDelete)
                    getTasks()
                    print("deleted task with id \(id)")
                }
                
            } catch let error {
                
                print("error deleting task \(id) from realm \(error.localizedDescription)")
            }
        }
    }
}

