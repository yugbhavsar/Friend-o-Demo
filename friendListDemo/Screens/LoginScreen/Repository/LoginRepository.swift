//
//  LoginRepository.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import Foundation
import CoreData

class LoginRepository {
    
    
    func loginUser(userModel: UserModel,completion: @escaping ((Bool, String )->Void)) {
        
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", userModel.email)
        
        do {
            let user = try DatabaseProvider.shared.context.fetch(fetchRequest)
            
            if user.count != 0 {
                if user.first?.password == userModel.password {
                    var userData = userModel
                    userData.userId = user.first?.userId ?? ""
                    GlobalFunction.shared.saveUserDetails(userModel: userData)
                    completion(true, "")
                }else{
                    completion(false, "Incorrect Password")
                }
            }else{
                completion(false, "User Not Found")
            }
        } catch {
            print("Fetch time Error",error)
            completion(false, "Something went wrong")
        }
    }
    
}