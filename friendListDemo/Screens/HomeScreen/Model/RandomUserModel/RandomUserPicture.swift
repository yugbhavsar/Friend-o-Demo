//
//	RandomUserPicture.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserPicture : NSObject, NSCoding{

	var large : String!
	var medium : String!
	var thumbnail : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		large = dictionary["large"] as? String
		medium = dictionary["medium"] as? String
		thumbnail = dictionary["thumbnail"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if large != nil{
			dictionary["large"] = large
		}
		if medium != nil{
			dictionary["medium"] = medium
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         large = aDecoder.decodeObject(forKey: "large") as? String
         medium = aDecoder.decodeObject(forKey: "medium") as? String
         thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if large != nil{
			aCoder.encode(large, forKey: "large")
		}
		if medium != nil{
			aCoder.encode(medium, forKey: "medium")
		}
		if thumbnail != nil{
			aCoder.encode(thumbnail, forKey: "thumbnail")
		}

	}

}