//
//	RandomUserLogin.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserLogin : NSObject, NSCoding{

	var md5 : String!
	var password : String!
	var salt : String!
	var sha1 : String!
	var sha256 : String!
	var username : String!
	var uuid : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		md5 = dictionary["md5"] as? String
		password = dictionary["password"] as? String
		salt = dictionary["salt"] as? String
		sha1 = dictionary["sha1"] as? String
		sha256 = dictionary["sha256"] as? String
		username = dictionary["username"] as? String
		uuid = dictionary["uuid"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if md5 != nil{
			dictionary["md5"] = md5
		}
		if password != nil{
			dictionary["password"] = password
		}
		if salt != nil{
			dictionary["salt"] = salt
		}
		if sha1 != nil{
			dictionary["sha1"] = sha1
		}
		if sha256 != nil{
			dictionary["sha256"] = sha256
		}
		if username != nil{
			dictionary["username"] = username
		}
		if uuid != nil{
			dictionary["uuid"] = uuid
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         md5 = aDecoder.decodeObject(forKey: "md5") as? String
         password = aDecoder.decodeObject(forKey: "password") as? String
         salt = aDecoder.decodeObject(forKey: "salt") as? String
         sha1 = aDecoder.decodeObject(forKey: "sha1") as? String
         sha256 = aDecoder.decodeObject(forKey: "sha256") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String
         uuid = aDecoder.decodeObject(forKey: "uuid") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if md5 != nil{
			aCoder.encode(md5, forKey: "md5")
		}
		if password != nil{
			aCoder.encode(password, forKey: "password")
		}
		if salt != nil{
			aCoder.encode(salt, forKey: "salt")
		}
		if sha1 != nil{
			aCoder.encode(sha1, forKey: "sha1")
		}
		if sha256 != nil{
			aCoder.encode(sha256, forKey: "sha256")
		}
		if username != nil{
			aCoder.encode(username, forKey: "username")
		}
		if uuid != nil{
			aCoder.encode(uuid, forKey: "uuid")
		}

	}

}