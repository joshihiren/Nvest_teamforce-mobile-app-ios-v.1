//
//  RegisterAppRootClass.swift
//  TeamForce
//
//  Created by Hiren Joshi on 05/02/21.
//

import Foundation
import SwiftyJSON


class RegisterAppRootClass : NSObject, NSCoding{

    var count : Int!
    var status : Bool!
    var userApps : [RegisterAppUserApp]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        count = json["count"].intValue
        status = json["status"].boolValue
        userApps = [RegisterAppUserApp]()
        let userAppsArray = json["userApps"].arrayValue
        for userAppsJson in userAppsArray{
            let value = RegisterAppUserApp(fromJson: userAppsJson)
            userApps.append(value)
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
        if status != nil{
            dictionary["status"] = status
        }
        if userApps != nil{
            var dictionaryElements = [[String:Any]]()
            for userAppsElement in userApps {
                dictionaryElements.append(userAppsElement.toDictionary())
            }
            dictionary["userApps"] = dictionaryElements
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         count = aDecoder.decodeObject(forKey: "count") as? Int
         status = aDecoder.decodeObject(forKey: "status") as? Bool
         userApps = aDecoder.decodeObject(forKey: "userApps") as? [RegisterAppUserApp]

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
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if userApps != nil{
            aCoder.encode(userApps, forKey: "userApps")
        }

    }

}

//class RegisterAppUserApp : NSObject, NSCoding{
//
//    var appCode : String!
//    var appIcon : String!
//    var appName : String!
//    var profileId : String!
//
//
//    /**
//     * Instantiate the instance using the passed json values to set the properties values
//     */
//    init(fromJson json: JSON!){
//        if json.isEmpty{
//            return
//        }
//        appCode = json["app_code"].stringValue
//        appIcon = json["app_icon"].stringValue
//        appName = json["app_name"].stringValue
//        profileId = json["profile_id"].stringValue
//    }
//
//    /**
//     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
//     */
//    func toDictionary() -> [String:Any]
//    {
//        var dictionary = [String:Any]()
//        if appCode != nil{
//            dictionary["app_code"] = appCode
//        }
//        if appIcon != nil{
//            dictionary["app_icon"] = appIcon
//        }
//        if appName != nil{
//            dictionary["app_name"] = appName
//        }
//        if profileId != nil{
//            dictionary["profile_id"] = profileId
//        }
//        return dictionary
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         appCode = aDecoder.decodeObject(forKey: "app_code") as? String
//         appIcon = aDecoder.decodeObject(forKey: "app_icon") as? String
//         appName = aDecoder.decodeObject(forKey: "app_name") as? String
//         profileId = aDecoder.decodeObject(forKey: "profile_id") as? String
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    func encode(with aCoder: NSCoder)
//    {
//        if appCode != nil{
//            aCoder.encode(appCode, forKey: "app_code")
//        }
//        if appIcon != nil{
//            aCoder.encode(appIcon, forKey: "app_icon")
//        }
//        if appName != nil{
//            aCoder.encode(appName, forKey: "app_name")
//        }
//        if profileId != nil{
//            aCoder.encode(profileId, forKey: "profile_id")
//        }
//
//    }
//
//}
