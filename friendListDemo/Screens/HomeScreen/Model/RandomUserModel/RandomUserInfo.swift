//
//	RandomUserInfo.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserInfo : NSObject, NSCoding{

	var page : Int!
	var results : Int!
	var seed : String!
	var version : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		page = dictionary["page"] as? Int
		results = dictionary["results"] as? Int
		seed = dictionary["seed"] as? String
		version = dictionary["version"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if page != nil{
			dictionary["page"] = page
		}
		if results != nil{
			dictionary["results"] = results
		}
		if seed != nil{
			dictionary["seed"] = seed
		}
		if version != nil{
			dictionary["version"] = version
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         page = aDecoder.decodeObject(forKey: "page") as? Int
         results = aDecoder.decodeObject(forKey: "results") as? Int
         seed = aDecoder.decodeObject(forKey: "seed") as? String
         version = aDecoder.decodeObject(forKey: "version") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if page != nil{
			aCoder.encode(page, forKey: "page")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}
		if seed != nil{
			aCoder.encode(seed, forKey: "seed")
		}
		if version != nil{
			aCoder.encode(version, forKey: "version")
		}

	}

}