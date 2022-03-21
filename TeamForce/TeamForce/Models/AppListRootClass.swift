//
//  AppListRootClass.swift
//  TeamForce
//
//  Created by Hiren Joshi on 31/01/21.
//

import Foundation
import SwiftyJSON


class AppListRootClass : NSObject, NSCoding{

    var count : Int!
    var logs : [AppListLog]!
    var status : Bool!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        count = json["count"].intValue
        logs = [AppListLog]()
        let logsArray = json["logs"].arrayValue
        for logsJson in logsArray{
            let value = AppListLog(fromJson: logsJson)
            logs.append(value)
        }
        status = json["status"].boolValue
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
        if logs != nil{
            var dictionaryElements = [[String:Any]]()
            for logsElement in logs {
                dictionaryElements.append(logsElement.toDictionary())
            }
            dictionary["logs"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
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
         logs = aDecoder.decodeObject(forKey: "logs") as? [AppListLog]
         status = aDecoder.decodeObject(forKey: "status") as? Bool

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
        if logs != nil{
            aCoder.encode(logs, forKey: "logs")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}

class AppListLog : NSObject, NSCoding{

    var id : String!
    var androidAppLink : String!
    var appCode : String!
    var commitDescription : String!
    var date : String!
    var iosAppLink : String!
    var linuxAppLink : String!
    var macAppLink : String!
    var timestamp : Int!
    var updateName : String!
    var windowsAppLink : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        androidAppLink = json["android_app_link"].stringValue
        appCode = json["app_code"].stringValue
        commitDescription = json["commit_description"].stringValue
        date = json["date"].stringValue
        iosAppLink = json["ios_app_link"].stringValue
        linuxAppLink = json["linux_app_link"].stringValue
        macAppLink = json["mac_app_link"].stringValue
        timestamp = json["timestamp"].intValue
        updateName = json["update_name"].stringValue
        windowsAppLink = json["windows_app_link"].stringValue
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
        if androidAppLink != nil{
            dictionary["android_app_link"] = androidAppLink
        }
        if appCode != nil{
            dictionary["app_code"] = appCode
        }
        if commitDescription != nil{
            dictionary["commit_description"] = commitDescription
        }
        if date != nil{
            dictionary["date"] = date
        }
        if iosAppLink != nil{
            dictionary["ios_app_link"] = iosAppLink
        }
        if linuxAppLink != nil{
            dictionary["linux_app_link"] = linuxAppLink
        }
        if macAppLink != nil{
            dictionary["mac_app_link"] = macAppLink
        }
        if timestamp != nil{
            dictionary["timestamp"] = timestamp
        }
        if updateName != nil{
            dictionary["update_name"] = updateName
        }
        if windowsAppLink != nil{
            dictionary["windows_app_link"] = windowsAppLink
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
         androidAppLink = aDecoder.decodeObject(forKey: "android_app_link") as? String
         appCode = aDecoder.decodeObject(forKey: "app_code") as? String
         commitDescription = aDecoder.decodeObject(forKey: "commit_description") as? String
         date = aDecoder.decodeObject(forKey: "date") as? String
         iosAppLink = aDecoder.decodeObject(forKey: "ios_app_link") as? String
         linuxAppLink = aDecoder.decodeObject(forKey: "linux_app_link") as? String
         macAppLink = aDecoder.decodeObject(forKey: "mac_app_link") as? String
         timestamp = aDecoder.decodeObject(forKey: "timestamp") as? Int
         updateName = aDecoder.decodeObject(forKey: "update_name") as? String
         windowsAppLink = aDecoder.decodeObject(forKey: "windows_app_link") as? String

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
        if androidAppLink != nil{
            aCoder.encode(androidAppLink, forKey: "android_app_link")
        }
        if appCode != nil{
            aCoder.encode(appCode, forKey: "app_code")
        }
        if commitDescription != nil{
            aCoder.encode(commitDescription, forKey: "commit_description")
        }
        if date != nil{
            aCoder.encode(date, forKey: "date")
        }
        if iosAppLink != nil{
            aCoder.encode(iosAppLink, forKey: "ios_app_link")
        }
        if linuxAppLink != nil{
            aCoder.encode(linuxAppLink, forKey: "linux_app_link")
        }
        if macAppLink != nil{
            aCoder.encode(macAppLink, forKey: "mac_app_link")
        }
        if timestamp != nil{
            aCoder.encode(timestamp, forKey: "timestamp")
        }
        if updateName != nil{
            aCoder.encode(updateName, forKey: "update_name")
        }
        if windowsAppLink != nil{
            aCoder.encode(windowsAppLink, forKey: "windows_app_link")
        }

    }

}
