//
//  HomeRepository.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import Foundation
import CoreData

class HomeRepository {
    
    var randomeUserResult = [RandomUserResult]()
    var favoirteUserResult = [RandomUserResult]()
    var isLoading: Bool = true
    
    func fetchRandomUserList(completoin: @escaping  (()->Void)) {
        
        var param: [String:Any] = [:]
        param["results"] = 1000
        
        ApiProivder.shared.request(param: param) { response in
            
            let data = RandomUserModel(fromDictionary: response)
            self.randomeUserResult = data.results ?? []
            self.isLoading = false
            completoin()
        }
    }
    
    func fetchUserFriendList(){
        
        if let currentUserData = GlobalFunction.shared.fetchUserModel() {
            
            let fetchRequest: NSFetchRequest<UserFriend> = UserFriend.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "userId == %@", currentUserData.userId)
            
            var friendsList: [RandomUserResult] = []
            
            do {
                let results = try DatabaseProvider.shared.context.fetch(fetchRequest)
                print(results.count)
                for data in results {
                    if let friendData = data.value(forKey: "userFriend") as? Data {
                        let userFriend = try NSKeyedUnarchiver.unarchivedObject(ofClass: RandomUserResult.self, from: friendData) as? RandomUserResult
                        if let friend = userFriend {
                            friendsList.append(friend)
                        }
                    }
                }
                self.favoirteUserResult = friendsList
            } catch let error as NSError {
                print("Could not fetch. \(error),")
            }
            
        }
    }
    
    func addToFavoriteList(friend: RandomUserResult) {
        
        if let currentUserData = GlobalFunction.shared.fetchUserModel() {
            
            let userFriendEntity = NSEntityDescription.entity(forEntityName: "UserFriend", in: DatabaseProvider.shared.context)!
            let userFriend = NSManagedObject(entity: userFriendEntity, insertInto: DatabaseProvider.shared.context)
            
            do {
                let friendData = try NSKeyedArchiver.archivedData(withRootObject: friend, requiringSecureCoding: false)
                
                // Set values
                userFriend.setValue(currentUserData.userId, forKey: "userId")
                userFriend.setValue(friendData, forKey: "userFriend")
            
                try DatabaseProvider.shared.context.save()
                print("Friend saved successfully")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
}
