//
//  DefaultsUser.swift
//  TeamForce
//
//  Created by Hiren Joshi on 26/01/21.
//

import UIKit

let UserDataKey         = "UserData"
let DefaultScene        = "UIScene"

enum UserDetails {
    case email
    case accessToken
    case refreshtoken
    case username
    case name
    case profile
    case profileimg
    case idtoken
    case devicetoken
}

@objc public class UserInfoData: NSObject {

    static let shared = UserInfoData()
    public var mydefault : UserDefaults!
    
    private override init() {
        self.mydefault = UserDefaults.standard
        self.mydefault.synchronize()
    }
    
    func SaveObjectdata(data: Any, forkey Key: String) {
        let personData = NSKeyedArchiver.archivedData(withRootObject: data)
        self.mydefault.set(personData, forKey: Key)
    }
    
    func GetObjectdata(key: String) -> Any? {
        let Data = self.mydefault.object(forKey: key) as! NSData?
        if Data == nil {
            return nil
        }
        else {
            let info = NSKeyedUnarchiver.unarchiveObject(with: Data! as Data) as Any
            return info
        }
    }
    
    func GetUserToken() -> String? {
        guard let rootdata = UserInfoData.shared.GetUserInfodata() else {
            return ""
        }
        guard let token: String = rootdata.accessToken else {
            return ""
        }
        return token
    }
    
    func SaveUserdata(info: LoginRootClass) -> Bool {
        let personData = NSKeyedArchiver.archivedData(withRootObject: info)
        self.mydefault.set(personData, forKey: UserDataKey)
        self.mydefault.synchronize()
        if info.accessToken.isEmpty && info.refreshToken.isEmpty && info.idToken.isEmpty {
            return false
        }
        return true
    }
    
    func GetUserInfodata() -> LoginRootClass? {
        let personData = self.mydefault.object(forKey: UserDataKey) as! NSData?
        if personData == nil {
            return nil
        }
        else {
            let info = NSKeyedUnarchiver.unarchiveObject(with: personData! as Data) as! LoginRootClass
//            let info = try NSKeyedUnarchiver.unarchivedObject(ofClass: UserinfoRootClass.self, from: personData! as Data)
            return info
        }
    }
    
    func userinfo(infotype: UserDetails) -> String {
        let info = self.GetUserInfodata()
        switch infotype {
        case .email:
            return (info?.user.email)!
        case .accessToken:
            return (info?.accessToken)!
        case .refreshtoken:
            return (info?.refreshToken)!
        case .username:
            return (info?.user.username)!
        case .name:
            return (info?.user.name)!
        case .profile:
            return (info?.user.id)!
        case .profileimg:
            return (info?.user.profileImg)!
        case .idtoken:
            return (info?.idToken)!
        case .devicetoken:
            return (info?.deviceKey)!
        }
    }
    
    @objc func UserLogout(successCallback: (() -> Void)?) {
        let domain = Bundle.main.bundleIdentifier!
        self.mydefault.removePersistentDomain(forName: domain)
        self.mydefault.synchronize()
        print(Array(self.mydefault.dictionaryRepresentation().keys).count)
        successCallback!()
    }
    
}
