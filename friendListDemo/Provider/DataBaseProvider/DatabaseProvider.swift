//
//  DatabaseProvider.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import UIKit
import CoreData

class DatabaseProvider {

    static let shared = DatabaseProvider()
    
    
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }


    func saveContext() {
        do {
            try context.save()
        }catch {
            print("Save Error :", error)
        }
    }
    
}
