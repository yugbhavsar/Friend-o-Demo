//
//	RandomUserName.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserName : NSObject, NSCoding{

	var first : String!
	var last : String!
	var title : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		first = dictionary["first"] as? String
		last = dictionary["last"] as? String
		title = dictionary["title"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if first != nil{
			dictionary["first"] = first
		}
		if last != nil{
			dictionary["last"] = last
		}
		if title != nil{
			dictionary["title"] = title
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         first = aDecoder.decodeObject(forKey: "first") as? String
         last = aDecoder.decodeObject(forKey: "last") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if first != nil{
			aCoder.encode(first, forKey: "first")
		}
		if last != nil{
			aCoder.encode(last, forKey: "last")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}

	}

}