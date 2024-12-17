//
//	RandomUserResult.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserResult : NSObject, NSCoding{

	var cell : String!
	var dob : RandomUserDob!
	var email : String!
	var gender : String!
	var id : RandomUserId!
	var location : RandomUserLocation!
	var login : RandomUserLogin!
	var name : RandomUserName!
	var nat : String!
	var phone : String!
	var picture : RandomUserPicture!
	var registered : RandomUserDob!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		cell = dictionary["cell"] as? String
		if let dobData = dictionary["dob"] as? [String:Any]{
			dob = RandomUserDob(fromDictionary: dobData)
		}
		email = dictionary["email"] as? String
		gender = dictionary["gender"] as? String
		if let idData = dictionary["id"] as? [String:Any]{
			id = RandomUserId(fromDictionary: idData)
		}
		if let locationData = dictionary["location"] as? [String:Any]{
			location = RandomUserLocation(fromDictionary: locationData)
		}
		if let loginData = dictionary["login"] as? [String:Any]{
			login = RandomUserLogin(fromDictionary: loginData)
		}
		if let nameData = dictionary["name"] as? [String:Any]{
			name = RandomUserName(fromDictionary: nameData)
		}
		nat = dictionary["nat"] as? String
		phone = dictionary["phone"] as? String
		if let pictureData = dictionary["picture"] as? [String:Any]{
			picture = RandomUserPicture(fromDictionary: pictureData)
		}
		if let registeredData = dictionary["registered"] as? [String:Any]{
			registered = RandomUserDob(fromDictionary: registeredData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if cell != nil{
			dictionary["cell"] = cell
		}
		if dob != nil{
			dictionary["dob"] = dob.toDictionary()
		}
		if email != nil{
			dictionary["email"] = email
		}
		if gender != nil{
			dictionary["gender"] = gender
		}
		if id != nil{
			dictionary["id"] = id.toDictionary()
		}
		if location != nil{
			dictionary["location"] = location.toDictionary()
		}
		if login != nil{
			dictionary["login"] = login.toDictionary()
		}
		if name != nil{
			dictionary["name"] = name.toDictionary()
		}
		if nat != nil{
			dictionary["nat"] = nat
		}
		if phone != nil{
			dictionary["phone"] = phone
		}
		if picture != nil{
			dictionary["picture"] = picture.toDictionary()
		}
		if registered != nil{
			dictionary["registered"] = registered.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         cell = aDecoder.decodeObject(forKey: "cell") as? String
         dob = aDecoder.decodeObject(forKey: "dob") as? RandomUserDob
         email = aDecoder.decodeObject(forKey: "email") as? String
         gender = aDecoder.decodeObject(forKey: "gender") as? String
         id = aDecoder.decodeObject(forKey: "id") as? RandomUserId
         location = aDecoder.decodeObject(forKey: "location") as? RandomUserLocation
         login = aDecoder.decodeObject(forKey: "login") as? RandomUserLogin
         name = aDecoder.decodeObject(forKey: "name") as? RandomUserName
         nat = aDecoder.decodeObject(forKey: "nat") as? String
         phone = aDecoder.decodeObject(forKey: "phone") as? String
         picture = aDecoder.decodeObject(forKey: "picture") as? RandomUserPicture
         registered = aDecoder.decodeObject(forKey: "registered") as? RandomUserDob

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if cell != nil{
			aCoder.encode(cell, forKey: "cell")
		}
		if dob != nil{
			aCoder.encode(dob, forKey: "dob")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if gender != nil{
			aCoder.encode(gender, forKey: "gender")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if location != nil{
			aCoder.encode(location, forKey: "location")
		}
		if login != nil{
			aCoder.encode(login, forKey: "login")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if nat != nil{
			aCoder.encode(nat, forKey: "nat")
		}
		if phone != nil{
			aCoder.encode(phone, forKey: "phone")
		}
		if picture != nil{
			aCoder.encode(picture, forKey: "picture")
		}
		if registered != nil{
			aCoder.encode(registered, forKey: "registered")
		}

	}

}