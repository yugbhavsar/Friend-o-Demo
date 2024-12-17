//
//  SignupRepository.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import Foundation
import CoreData


class SignupRepository {
    
    
    func addUser(user: UserModel , completion: @escaping ((Bool,String)->Void)) {
        if !checkForExitstingUser(byEmail: user.email) {
            
            let saveUser: User = User(context: DatabaseProvider.shared.context)
            saveUser.firstName = user.firstName
            saveUser.lastName = user.LastName
            saveUser.email = user.email
            saveUser.password = user.password
            saveUser.userId = UUID().uuidString
            
            DatabaseProvider.shared.saveContext()
            completion(true,"")
        }else{
            completion(false,"Email is already registered")
        }
    }
    
    func checkForExitstingUser(byEmail: String) -> Bool {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", byEmail)
        
        do {
         let user = try DatabaseProvider.shared.context.fetch(fetchRequest)
            return user.count > 0
        } catch {
            print("Fetch time Error",error)
            return true
        }
    }
}
