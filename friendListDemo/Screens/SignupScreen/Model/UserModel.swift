//
//  UserModel.swift
//  friendListDemo
//
//  Created by Techify on 17/12/24.
//

import Foundation


struct UserModel: Codable {
    
    var firstName:String
    var LastName:String
    var email:String
    var password:String
    var userId: String = ""
    
    
}
