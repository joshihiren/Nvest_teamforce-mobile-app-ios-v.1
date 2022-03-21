//
//    LoginRootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class LoginRootClass : NSObject, NSCoding{
    
    var errObj : LoginErrObj!
    var mfa : Bool!
    var accessToken : String!
    var deviceKey : String!
    var idToken : String!
    var message : String!
    var refreshToken : String!
    var status : Bool!
    var user : UserInfoUser!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty {
            return
        }
        let errObjJson = json["errObj"]
        if !errObjJson.isEmpty{
            errObj = LoginErrObj(fromJson: errObjJson)
        }
        mfa = json["mfa"].boolValue
        if json.isEmpty{
            return
        }
        accessToken = json["accessToken"].stringValue
        deviceKey = json["device_key"].stringValue
        idToken = json["idToken"].stringValue
        refreshToken = json["refreshToken"].stringValue
        let userJson = json["user"]
        if !userJson.isEmpty{
            user = UserInfoUser(fromJson: userJson)
        }
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if errObj != nil{
            dictionary["errObj"] = errObj.toDictionary()
        }
        if mfa != nil{
            dictionary["mfa"] = mfa
        }
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if deviceKey != nil{
            dictionary["device_key"] = deviceKey
        }
        if idToken != nil{
            dictionary["idToken"] = idToken
        }
        if message != nil{
            dictionary["message"] = message
        }
        if refreshToken != nil{
            dictionary["refreshToken"] = refreshToken
        }
        if status != nil{
            dictionary["status"] = status
        }
        if user != nil{
            dictionary["user"] = user.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        errObj = aDecoder.decodeObject(forKey: "errObj") as? LoginErrObj
        mfa = aDecoder.decodeObject(forKey: "mfa") as? Bool
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        deviceKey = aDecoder.decodeObject(forKey: "device_key") as? String
        idToken = aDecoder.decodeObject(forKey: "idToken") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        refreshToken = aDecoder.decodeObject(forKey: "refreshToken") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Bool
        user = aDecoder.decodeObject(forKey: "user") as? UserInfoUser
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if errObj != nil{
            aCoder.encode(errObj, forKey: "errObj")
        }
        if mfa != nil{
            aCoder.encode(mfa, forKey: "mfa")
        }
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if deviceKey != nil{
            aCoder.encode(deviceKey, forKey: "device_key")
        }
        if idToken != nil{
            aCoder.encode(idToken, forKey: "idToken")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if refreshToken != nil{
            aCoder.encode(refreshToken, forKey: "refreshToken")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}

class LoginErrObj : NSObject, NSCoding{
    
    var code : String!
    var message : String!
    var name : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        code = json["code"].stringValue
        message = json["message"].stringValue
        name = json["name"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if code != nil{
            dictionary["code"] = code
        }
        if message != nil{
            dictionary["message"] = message
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        
    }
    
}

class UserInfoUser : NSObject, NSCoding{
    
    var id : String!
    var affiliateId : String!
    var clientApp : String!
    var cognitoUsername : String!
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
        clientApp = json["client_app"].stringValue
        cognitoUsername = json["cognito_username"].stringValue
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
        if clientApp != nil{
            dictionary["client_app"] = clientApp
        }
        if cognitoUsername != nil{
            dictionary["cognito_username"] = cognitoUsername
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
        clientApp = aDecoder.decodeObject(forKey: "client_app") as? String
        cognitoUsername = aDecoder.decodeObject(forKey: "cognito_username") as? String
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
        if clientApp != nil{
            aCoder.encode(clientApp, forKey: "client_app")
        }
        if cognitoUsername != nil{
            aCoder.encode(cognitoUsername, forKey: "cognito_username")
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
