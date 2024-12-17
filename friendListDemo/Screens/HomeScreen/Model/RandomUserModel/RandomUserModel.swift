//
//	RandomUserModel.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserModel : NSObject, NSCoding{

	var info : RandomUserInfo!
	var results : [RandomUserResult]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let infoData = dictionary["info"] as? [String:Any]{
			info = RandomUserInfo(fromDictionary: infoData)
		}
		results = [RandomUserResult]()
		if let resultsArray = dictionary["results"] as? [[String:Any]]{
			for dic in resultsArray{
				let value = RandomUserResult(fromDictionary: dic)
				results.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if info != nil{
			dictionary["info"] = info.toDictionary()
		}
		if results != nil{
			var dictionaryElements = [[String:Any]]()
			for resultsElement in results {
				dictionaryElements.append(resultsElement.toDictionary())
			}
			dictionary["results"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         info = aDecoder.decodeObject(forKey: "info") as? RandomUserInfo
         results = aDecoder.decodeObject(forKey :"results") as? [RandomUserResult]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if info != nil{
			aCoder.encode(info, forKey: "info")
		}
		if results != nil{
			aCoder.encode(results, forKey: "results")
		}

	}

}