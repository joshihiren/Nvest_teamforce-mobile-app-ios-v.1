//
//  Constants.swift
//  TeamForce
//
//  Created by Hiren Joshi on 16/01/21.
//

import Foundation
import SwiftUI
import UIKit

// API Calling Constant
public enum API_Services {
    case LoginAPI
    case AppListAPI
    case registerAppsAPI
    case CurrencyAPI
    case TranferAPI
    case CurrencyConvertAPI
    case ReciepientUserAPI
    
    func ServiceFunctions() -> String {
        switch self {
        
        case.LoginAPI:
            return "https://gxauth.apimachine.com/gx/user/login"
            
        case .AppListAPI:
            return "https://comms.globalxchange.com/gxb/apps/mobile/app/links/logs/get"
            
        case .registerAppsAPI:
            return "https://comms.globalxchange.com/gxb/apps/registered/user?email="
            
        case .CurrencyAPI:
            return "https://comms.globalxchange.com/coin/vault/service/coins/get"
            
        case .TranferAPI:
            return "https://comms.globalxchange.com/coin/vault/service/encode/decode/data"
            
        case .CurrencyConvertAPI:
            return ""
            
        case .ReciepientUserAPI:
            return "https://comms.globalxchange.com/coin/vault/service/users/holdings/data/get?email="
        }
    }
    
}

public let OrangeColor                      = Color("Orange")
public let BackgroundColor                  = Color("Background")
public let LineColor                        = Color("Lines")
public let TextColor                        = Color("TextColor")
public let DarkTextColor                    = Color("DarkTextColor")
public let GreenColor                       = Color("Green")

public let MontserratBlackFont              = "Montserrat-Black"
public let MontserratBlackItalicFont        = "Montserrat-BlackItalic"
public let MontserratBoldFont               = "Montserrat-Bold"
public let MontserratBoldItalicFont         = "Montserrat-BoldItalic"
public let MontserratExtraBoldFont          = "Montserrat-ExtraBold"
public let MontserratExtraBoldItalicFont    = "Montserrat-ExtraBoldItalic"
public let MontserratExtraLightFont         = "Montserrat-ExtraLight"
public let MontserratExtraLightItalicFont   = "Montserrat-ExtraLightItalic"
public let MontserratItalicFont             = "Montserrat-Italic"
public let MontserratLightFont              = "Montserrat-Light"
public let MontserratLightItalicFont        = "Montserrat-LightItalic"
public let MontserratMediumFont             = "Montserrat-Medium"
public let MontserratMediumItalicFont       = "Montserrat-MediumItalic"
public let MontserratRegularFont            = "Montserrat-Regular"
public let MontserratSemiBoldFont           = "Montserrat-SemiBold"
public let MontserratSemiBoldItalicFont     = "Montserrat-SemiBoldItalic"
public let MontserratThinFont               = "Montserrat-Thin"
public let MontserratThinItalicFont         = "Montserrat-ThinItalic"

let __firstpart                             = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let __serverpart                            = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let __emailRegex                            = "\(__firstpart)@\(__serverpart)[A-Za-z]{2,8}"
let __emailPredicate                        = NSPredicate(format: "SELF MATCHES %@", __emailRegex)

public let ShortVersion                     = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
public let DisplayName                      = Bundle.main.infoDictionary?["CFBundleName"] as! String
public let BuildName                        = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

// MARK: - -------------------- UIResponder --------------------
// MARK: -

public let iPhone12_ProMax                  = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1170, height: 2532)) ?? false
public let iPhone12_Pro                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1284, height: 2778)) ?? false
public let iPhone12                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1170, height: 2532)) ?? false
public let iPhone12_mini                    = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1080, height: 2340)) ?? false
public let iPhone11                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 828, height: 1792)) ?? false
public let iPhone11_Pro                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1125, height: 2436)) ?? false
public let iPhone11_ProMax                  = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1242, height: 2688)) ?? false
public let iPhoneXR                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 828, height: 1792)) ?? false
public let iPhoneXS                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1125, height: 2436)) ?? false
public let iPhoneXS_Max                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1242, height: 2688)) ?? false
public let iPhoneX                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1125, height: 2436)) ?? false
public let iPhone8_Plus                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1080, height: 1920)) ?? false
public let iPhone8                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 750, height: 1334)) ?? false
public let iPhoneSE_2ndGen                  = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 750, height: 1334)) ?? false
public let iPhone7_Plus                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1080, height: 1920)) ?? false
public let iPhone7                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 750, height: 1334)) ?? false
public let iPhoneSE                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 1136)) ?? false
public let iPhone6s_Plus                    = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1080, height: 1920)) ?? false
public let iPhone6s                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 750, height: 1334)) ?? false
public let iPhone6_Plus                     = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1080, height: 1920)) ?? false
public let iPhone6                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 750, height: 1334)) ?? false
public let iPhone5S                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 1136)) ?? false
public let iPhone5C                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 1136)) ?? false
public let iPhone5                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 1136)) ?? false
public let iPhone4S                         = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 960)) ?? false
public let iPhone4                          = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 640, height: 960)) ?? false
public let iPhone3GS                        = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 480, height: 320)) ?? false

public let Screen_width                     = UIScreen.main.bounds.size.width
public let Screen_height                    = UIScreen.main.bounds.size.height
public let Language                         = NSLocale.preferredLanguages.first
public let isIphoneXR                       = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 828, height: 1792)) ?? false
public let isIphoneXSMAX                    = UIScreen.main.currentMode?.size.equalTo(CGSize (width: 1242, height: 2688)) ?? false
public let isXseries                        = isIphoneX || isIphoneXR || isIphoneXSMAX || iPhone12_ProMax || iPhone12_Pro || iPhone12 || iPhone12_mini || iPhone11 || iPhone11_Pro || iPhone11_ProMax || iPhoneXR || iPhoneXS || iPhoneXS_Max || iPhoneX

public let TopNavHeight : CGFloat           = isXseries ? 84 : 64
public let TabbarHeight : CGFloat           = isXseries ? 83 : 49
public let StateBarHeight : CGFloat         = isXseries ? 44 : 20
public let NavBarHeight : CGFloat           = isXseries ? 64 : 44
public let BottomSafeAreaHeight : CGFloat   = isXseries ? 34 : 0
public let TopSafeAreaHeight : CGFloat      = isXseries ? 24 : 0
public let UnderSafeArea : CGFloat          = isXseries ? 24 : 20

public let isIphone5 : Bool                 = (UIScreen.main.bounds.height == 568) //se
public let isIphone6 : Bool                 = (UIScreen.main.bounds.height == 667) //6/6s/7/7s/8
public let isIphone6P : Bool                = (UIScreen.main.bounds.height == 736) //6p/6sp/7p/7sp/8p
public let isIphoneX : Bool                 = Int((Screen_height / Screen_width) * 100) == 216 ? true : false

let App                                     = UIApplication.shared.delegate as? AppDelegate
let AppScene                                = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate

func background(work: @escaping () -> ()) {
    DispatchQueue.global(qos: .userInitiated).async {
        work()
    }
}

func main(work: @escaping () -> ()) {
    DispatchQueue.main.async {
        work()
    }
}

func delaymain(delay: Double, work: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        work()
    }
}

//struct PluginVaultParam {
//    var Source_Apps: [RegisterAppUserApp]? = nil
//    var Source_SelectedApp: RegisterAppUserApp? = nil
//    var Source_Currencies: [CurrencyCoinsData]? = nil
//    var Source_SelectedCurrency: CurrencyCoinsData? = nil
//    var Desti_SelectedApp: RegisterAppUserApp? = nil
//    var Desti_SelectedCurrency: CurrencyCoinsData? = nil
//    var Amount_sending: Double? = nil
//    var Amount_recieving: Double? = nil
//}

struct VaultTransferParam: Encodable {
    
    var token: String?
    var email: String?
    var from_appcode: String?
    var from_profileid: String?
    var from_coin: String?
    var to_appcode: String?
    var to_profileid: String?
    var to_coin: String?
    var to_amount: Double?
    var identifier: String?
    var transfer_for: String?
    
    var description: [String : Any] {
        get {
            return ["data" :
                        [
                            "token" : self.token! as String,
                            "email" : self.email! as String,
                            "to_amount": self.to_amount! as Double,
                            "identifier": self.identifier! as String,
                            "transfer_for": self.transfer_for! as String,
                            "from": [
                                "app_code": self.from_appcode! as String,
                                "profile_id": self.from_profileid! as String,
                                "coin": self.from_coin! as String
                            ],
                            "to": [
                                "app_code": self.to_appcode! as String,
                                "profile_id": self.to_profileid! as String,
                                "coin": self.to_coin! as String
                            ]
                        ],
                    "encode": true
            ]
        }
    }
}
