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
            
            //password comparise with login information
            if user.count != 0 {
                // making sure to decrypt password to cross check
                if GlobalFunction.shared.decrypt(encryptedText: user.first?.password ?? "") == userModel.password {
                    var userData = userModel
                    userData.userId = user.first?.userId ?? ""
                    GlobalFunction.shared.saveUserDetails(userModel: userData)
                    completion(true, "Login success")
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
