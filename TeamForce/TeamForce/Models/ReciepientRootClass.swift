//
//  ReciepientRootClass.swift
//  TeamForce
//
//  Created by Hiren Joshi on 15/02/21.
//

import Foundation
import SwiftyJSON


class ReciepientRootClass : NSObject, NSCoding {

    var count : Double!
    var limit : Double!
    var skip : Double!
    var status : Bool!
    var totalUsersCount : Double!
    var users : [ReciepientUser]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        count = json["count"].doubleValue
        limit = json["limit"].doubleValue
        skip = json["skip"].doubleValue
        status = json["status"].boolValue
        totalUsersCount = json["totalUsersCount"].doubleValue
        users = [ReciepientUser]()
        let usersArray = json["users"].arrayValue
        for usersJson in usersArray{
            let value = ReciepientUser(fromJson: usersJson)
            users.append(value)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if count != nil{
            dictionary["count"] = count
        }
        if limit != nil{
            dictionary["limit"] = limit
        }
        if skip != nil{
            dictionary["skip"] = skip
        }
        if status != nil{
            dictionary["status"] = status
        }
        if totalUsersCount != nil{
            dictionary["totalUsersCount"] = totalUsersCount
        }
        if users != nil{
            var dictionaryElements = [[String:Any]]()
            for usersElement in users {
                dictionaryElements.append(usersElement.toDictionary())
            }
            dictionary["users"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         count = aDecoder.decodeObject(forKey: "count") as? Double
         limit = aDecoder.decodeObject(forKey: "limit") as? Double
         skip = aDecoder.decodeObject(forKey: "skip") as? Double
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         totalUsersCount = aDecoder.decodeObject(forKey: "totalUsersCount") as? Double
         users = aDecoder.decodeObject(forKey: "users") as? [ReciepientUser]

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if count != nil{
            aCoder.encode(count, forKey: "count")
        }
        if limit != nil{
            aCoder.encode(limit, forKey: "limit")
        }
        if skip != nil{
            aCoder.encode(skip, forKey: "skip")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if totalUsersCount != nil{
            aCoder.encode(totalUsersCount, forKey: "totalUsersCount")
        }
        if users != nil{
            aCoder.encode(users, forKey: "users")
        }

    }

}

class ReciepientUser : NSObject, NSCoding{

    var appsData : RegisterAppUserApp!
    var bond : Double!
    var icedInterest : Double!
    var liquidInterest : Double!
    var liquidHoldings : Double!
    var refUserData : ReciepientRefUserData!
    var totalBondEarnings : Double!
    var totalLiquidEarnings : Double!
    var totalHoldings : Double!
    var userData : ReciepientUserData!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        let appsDataJson = json["appsData"]
        if !appsDataJson.isEmpty{
            appsData = RegisterAppUserApp(fromJson: appsDataJson)
        }
        bond = json["bond"].doubleValue
        icedInterest = json["icedInterest"].doubleValue
        liquidInterest = json["liquidInterest"].doubleValue
        liquidHoldings = json["liquid_holdings"].doubleValue
        let refUserDataJson = json["refUserData"]
        if !refUserDataJson.isEmpty{
            refUserData = ReciepientRefUserData(fromJson: refUserDataJson)
        }
        totalBondEarnings = json["totalBondEarnings"].doubleValue
        totalLiquidEarnings = json["totalLiquidEarnings"].doubleValue
        totalHoldings = json["total_holdings"].doubleValue
        let userDataJson = json["userData"]
        if !userDataJson.isEmpty{
            userData = ReciepientUserData(fromJson: userDataJson)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appsData != nil{
            dictionary["appsData"] = appsData.toDictionary()
        }
        if bond != nil{
            dictionary["bond"] = bond
        }
        if icedInterest != nil{
            dictionary["icedInterest"] = icedInterest
        }
        if liquidInterest != nil{
            dictionary["liquidInterest"] = liquidInterest
        }
        if liquidHoldings != nil{
            dictionary["liquid_holdings"] = liquidHoldings
        }
        if refUserData != nil{
            dictionary["refUserData"] = refUserData.toDictionary()
        }
        if totalBondEarnings != nil{
            dictionary["totalBondEarnings"] = totalBondEarnings
        }
        if totalLiquidEarnings != nil{
            dictionary["totalLiquidEarnings"] = totalLiquidEarnings
        }
        if totalHoldings != nil{
            dictionary["total_holdings"] = totalHoldings
        }
        if userData != nil{
            dictionary["userData"] = userData.toDictionary()
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         appsData = aDecoder.decodeObject(forKey: "appsData") as? RegisterAppUserApp
         bond = aDecoder.decodeObject(forKey: "bond") as? Double
         icedInterest = aDecoder.decodeObject(forKey: "icedInterest") as? Double
         liquidInterest = aDecoder.decodeObject(forKey: "liquidInterest") as? Double
         liquidHoldings = aDecoder.decodeObject(forKey: "liquid_holdings") as? Double
         refUserData = aDecoder.decodeObject(forKey: "refUserData") as? ReciepientRefUserData
         totalBondEarnings = aDecoder.decodeObject(forKey: "totalBondEarnings") as? Double
         totalLiquidEarnings = aDecoder.decodeObject(forKey: "totalLiquidEarnings") as? Double
         totalHoldings = aDecoder.decodeObject(forKey: "total_holdings") as? Double
         userData = aDecoder.decodeObject(forKey: "userData") as? ReciepientUserData

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if appsData != nil{
            aCoder.encode(appsData, forKey: "appsData")
        }
        if bond != nil{
            aCoder.encode(bond, forKey: "bond")
        }
        if icedInterest != nil{
            aCoder.encode(icedInterest, forKey: "icedInterest")
        }
        if liquidInterest != nil{
            aCoder.encode(liquidInterest, forKey: "liquidInterest")
        }
        if liquidHoldings != nil{
            aCoder.encode(liquidHoldings, forKey: "liquid_holdings")
        }
        if refUserData != nil{
            aCoder.encode(refUserData, forKey: "refUserData")
        }
        if totalBondEarnings != nil{
            aCoder.encode(totalBondEarnings, forKey: "totalBondEarnings")
        }
        if totalLiquidEarnings != nil{
            aCoder.encode(totalLiquidEarnings, forKey: "totalLiquidEarnings")
        }
        if totalHoldings != nil{
            aCoder.encode(totalHoldings, forKey: "total_holdings")
        }
        if userData != nil{
            aCoder.encode(userData, forKey: "userData")
        }

    }

}


class ReciepientUserData : NSObject, NSCoding{

    var affiliateId : String!
    var date : String!
    var email : String!
    var name : String!
    var profileImg : String!
    var refAffiliate : String!
    var username : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        affiliateId = json["affiliate_id"].stringValue
        date = json["date"].stringValue
        email = json["email"].stringValue
        name = json["name"].stringValue
        profileImg = json["profile_img"].stringValue
        refAffiliate = json["ref_affiliate"].stringValue
        username = json["username"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if affiliateId != nil{
            dictionary["affiliate_id"] = affiliateId
        }
        if date != nil{
            dictionary["date"] = date
        }
        if email != nil{
            dictionary["email"] = email
        }
        if name != nil{
            dictionary["name"] = name
        }
        if profileImg != nil{
            dictionary["profile_img"] = profileImg
        }
        if refAffiliate != nil{
            dictionary["ref_affiliate"] = refAffiliate
        }
        if username != nil{
            dictionary["username"] = username
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         affiliateId = aDecoder.decodeObject(forKey: "affiliate_id") as? String
         date = aDecoder.decodeObject(forKey: "date") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         profileImg = aDecoder.decodeObject(forKey: "profile_img") as? String
         refAffiliate = aDecoder.decodeObject(forKey: "ref_affiliate") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if affiliateId != nil{
            aCoder.encode(affiliateId, forKey: "affiliate_id")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if profileImg != nil{
            aCoder.encode(profileImg, forKey: "profile_img")
        }
        if refAffiliate != nil{
            aCoder.encode(refAffiliate, forKey: "ref_affiliate")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }

    }

}

class ReciepientRefUserData : NSObject, NSCoding{

    var id : String!
    var affiliateId : String!
    var email : String!
    var name : String!
    var profileImg : String!
    var refAffiliate : String!
    var username : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        affiliateId = json["affiliate_id"].stringValue
        email = json["email"].stringValue
        name = json["name"].stringValue
        profileImg = json["profile_img"].stringValue
        refAffiliate = json["ref_affiliate"].stringValue
        username = json["username"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["_id"] = id
        }
        if affiliateId != nil{
            dictionary["affiliate_id"] = affiliateId
        }
        if email != nil{
            dictionary["email"] = email
        }
        if name != nil{
            dictionary["name"] = name
        }
        if profileImg != nil{
            dictionary["profile_img"] = profileImg
        }
        if refAffiliate != nil{
            dictionary["ref_affiliate"] = refAffiliate
        }
        if username != nil{
            dictionary["username"] = username
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         id = aDecoder.decodeObject(forKey: "_id") as? String
         affiliateId = aDecoder.decodeObject(forKey: "affiliate_id") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         profileImg = aDecoder.decodeObject(forKey: "profile_img") as? String
         refAffiliate = aDecoder.decodeObject(forKey: "ref_affiliate") as? String
         username = aDecoder.decodeObject(forKey: "username") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if affiliateId != nil{
            aCoder.encode(affiliateId, forKey: "affiliate_id")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if profileImg != nil{
            aCoder.encode(profileImg, forKey: "profile_img")
        }
        if refAffiliate != nil{
            aCoder.encode(refAffiliate, forKey: "ref_affiliate")
        }
        if username != nil{
            aCoder.encode(username, forKey: "username")
        }

    }

}

class RegisterAppUserApp : NSObject, NSCoding {

    var appCode : String!
    var appIcon : String!
    var appName : String!
    var profileId : String!
    var totalValue : Double!
    var id : String!
    var appsData : [RegisterAppUserApp]!
    var totalHoldings : Double!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        appCode = json["app_code"].stringValue
        appIcon = json["app_icon"].stringValue
        appName = json["app_name"].stringValue
        totalValue = json["totalValue"].doubleValue
        profileId = json["profile_id"].stringValue
        id = json["_id"].stringValue
        appsData = [RegisterAppUserApp]()
        let appsDataArray = json["appsData"].arrayValue
        for appsDataJson in appsDataArray{
            let value = RegisterAppUserApp(fromJson: appsDataJson)
            appsData.append(value)
        }
        totalHoldings = json["total_holdings"].doubleValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if appCode != nil{
            dictionary["app_code"] = appCode
        }
        if appIcon != nil{
            dictionary["app_icon"] = appIcon
        }
        if appName != nil{
            dictionary["app_name"] = appName
        }
        if profileId != nil{
            dictionary["profile_id"] = profileId
        }
        if totalValue != nil{
            dictionary["totalValue"] = totalValue
        }
        if id != nil{
            dictionary["_id"] = id
        }
        if appsData != nil{
            var dictionaryElements = [[String:Any]]()
            for appsDataElement in appsData {
                dictionaryElements.append(appsDataElement.toDictionary())
            }
            dictionary["appsData"] = dictionaryElements
        }
        if totalHoldings != nil{
            dictionary["total_holdings"] = totalHoldings
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         appCode = aDecoder.decodeObject(forKey: "app_code") as? String
         appIcon = aDecoder.decodeObject(forKey: "app_icon") as? String
         appName = aDecoder.decodeObject(forKey: "app_name") as? String
        profileId = aDecoder.decodeObject(forKey: "profile_id") as? String
         totalValue = aDecoder.decodeObject(forKey: "totalValue") as? Double
         id = aDecoder.decodeObject(forKey: "_id") as? String
         appsData = aDecoder.decodeObject(forKey: "appsData") as? [RegisterAppUserApp]
         totalHoldings = aDecoder.decodeObject(forKey: "total_holdings") as? Double

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if appCode != nil{
            aCoder.encode(appCode, forKey: "app_code")
        }
        if appIcon != nil{
            aCoder.encode(appIcon, forKey: "app_icon")
        }
        if appName != nil{
            aCoder.encode(appName, forKey: "app_name")
        }
        if profileId != nil{
            aCoder.encode(profileId, forKey: "profile_id")
        }
        if totalValue != nil{
            aCoder.encode(totalValue, forKey: "totalValue")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if appsData != nil{
            aCoder.encode(appsData, forKey: "appsData")
        }
        if totalHoldings != nil{
            aCoder.encode(totalHoldings, forKey: "total_holdings")
        }

    }

}
