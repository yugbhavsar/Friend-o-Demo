//
//  HomeRepository.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import Foundation
import CoreData

// update UI every time while Fetching/Updating user
protocol FetchFavoriteDelegate {
    
    func didFetchUserFavList()
}

class HomeRepository {
    
    var randomeUserResult = [RandomUserResult]()
    var favoirteUserResult = [RandomUserResult]()
    var userFavEntityList = [UserFriend]() //specif required to remove fav user using Entity
    
    var delegate: FetchFavoriteDelegate?
    var isLoading: Bool = true
    var selectedTab: Int = 0
    
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
                self.userFavEntityList = results
                for data in results {
                    if let friendData = data.value(forKey: "userFriend") as? Data {
                        if let userFriend = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(friendData) as? RandomUserResult {
                            friendsList.append(userFriend)
                        } else {
                            print("Failed to decode RandomUserResult.")
                        }
                    }
                }
                self.favoirteUserResult = friendsList
                self.delegate?.didFetchUserFavList()
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

                userFriend.setValue(currentUserData.userId, forKey: "userId")
                userFriend.setValue(friendData, forKey: "userFriend")
            
                try DatabaseProvider.shared.context.save()
                GlobalFunction.shared.showToast(message: "User added to favorite list")
                self.fetchUserFriendList()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func removeFromFavoriteList(favoriteUser: UserFriend) {
        
        do {
            DatabaseProvider.shared.context.delete(favoriteUser)
            DatabaseProvider.shared.saveContext()
            self.fetchUserFriendList()
        } catch let error as NSError {
            print("Could not remove. \(error), \(error.userInfo)")
        }
        
    }
}
