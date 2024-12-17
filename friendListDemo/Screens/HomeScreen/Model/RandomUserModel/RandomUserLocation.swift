//
//	RandomUserLocation.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RandomUserLocation : NSObject, NSCoding{

	var city : String!
	var coordinates : RandomUserCoordinate!
	var country : String!
	var postcode : String!
	var state : String!
	var street : RandomUserStreet!
	var timezone : RandomUserTimezone!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		city = dictionary["city"] as? String
		if let coordinatesData = dictionary["coordinates"] as? [String:Any]{
			coordinates = RandomUserCoordinate(fromDictionary: coordinatesData)
		}
		country = dictionary["country"] as? String
		postcode = dictionary["postcode"] as? String
		state = dictionary["state"] as? String
		if let streetData = dictionary["street"] as? [String:Any]{
			street = RandomUserStreet(fromDictionary: streetData)
		}
		if let timezoneData = dictionary["timezone"] as? [String:Any]{
			timezone = RandomUserTimezone(fromDictionary: timezoneData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if city != nil{
			dictionary["city"] = city
		}
		if coordinates != nil{
			dictionary["coordinates"] = coordinates.toDictionary()
		}
		if country != nil{
			dictionary["country"] = country
		}
		if postcode != nil{
			dictionary["postcode"] = postcode
		}
		if state != nil{
			dictionary["state"] = state
		}
		if street != nil{
			dictionary["street"] = street.toDictionary()
		}
		if timezone != nil{
			dictionary["timezone"] = timezone.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         city = aDecoder.decodeObject(forKey: "city") as? String
         coordinates = aDecoder.decodeObject(forKey: "coordinates") as? RandomUserCoordinate
         country = aDecoder.decodeObject(forKey: "country") as? String
         postcode = aDecoder.decodeObject(forKey: "postcode") as? String
         state = aDecoder.decodeObject(forKey: "state") as? String
         street = aDecoder.decodeObject(forKey: "street") as? RandomUserStreet
         timezone = aDecoder.decodeObject(forKey: "timezone") as? RandomUserTimezone

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if city != nil{
			aCoder.encode(city, forKey: "city")
		}
		if coordinates != nil{
			aCoder.encode(coordinates, forKey: "coordinates")
		}
		if country != nil{
			aCoder.encode(country, forKey: "country")
		}
		if postcode != nil{
			aCoder.encode(postcode, forKey: "postcode")
		}
		if state != nil{
			aCoder.encode(state, forKey: "state")
		}
		if street != nil{
			aCoder.encode(street, forKey: "street")
		}
		if timezone != nil{
			aCoder.encode(timezone, forKey: "timezone")
		}

	}

}