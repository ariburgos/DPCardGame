//
//  StorageManager.swift
//  DeltapathCardGame
//
//  Created by Viajeros Lado B on 17/02/2020.
//  Copyright © 2020 DragonShine. All rights reserved.
//

import Foundation
import CoreData

class StorageManager {
    static let shared = StorageManager()
    var context: NSManagedObjectContext?
    
    func configure(context: NSManagedObjectContext){
        self.context = context
    }
    
    func create(name: String, score: Int16) {
        guard let context = context else { return }
        let newItem = NSEntityDescription.insertNewObject(forEntityName: "Player", into: context) as! Player
        newItem.name = name
        newItem.score = score
        saveChanges()
        return
    }
    
    func getById(id: NSManagedObjectID) -> Player? {
        guard let context = context else { return nil }
        return context.object(with: id) as? Player
    }
    
    func getAll() -> [Player] {
        return get(withPredicate: NSPredicate(value:true))
    }
        
    func getAllOrderedByScore() -> [Player] {
        return get(withPredicate: NSPredicate(value:true), sortDescriptors: [NSSortDescriptor(key: "score", ascending: false)])
    }

    func get(withPredicate queryPredicate: NSPredicate, sortDescriptors: [NSSortDescriptor]? = nil) -> [Player] {
        guard let context = context else { return [] }

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
        
        fetchRequest.predicate = queryPredicate
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        do {
            let response = try context.fetch(fetchRequest)
            return response as! [Player]
            
        } catch let error as NSError {
            // failure
            print(error)
            return [Player]()
        }
    }
    
    func update(updatedPlayer: Player) {
        if let person = getById(id: updatedPlayer.objectID){
            person.name = updatedPlayer.name
            person.score = updatedPlayer.score
        }
    }
    
    func delete(id: NSManagedObjectID) {
        guard let context = context else { return }

        if let playerToDeleter = getById(id: id){
            context.delete(playerToDeleter)
        }
    }

    func saveChanges() {
        guard let context = context else { return }

        do{
            try context.save()
        } catch let error as NSError {
            // failure
            print(error)
        }
    }

}
