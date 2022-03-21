//
//  LoginCallingModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class LoginCallingModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var loginService: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var userinfo: LoginRootClass = LoginRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }
    
    @Published var Userdata: [LoginRootClass] = [LoginRootClass]() {
       willSet {
           willChange.send()
       }
    }
    
    func loginAPI(email: String, password: String, successCallback: ((_ is2stepVerification: Bool) -> Void)?) {
        let params = ["email": email, "password": password]
        loginService.RxLoginService(parameters: params) { (response) in
            print("Response \(response)")
            self.Userdata = response
            self.userinfo = response.first!
            if self.userinfo.accessToken.isEmpty && self.userinfo.refreshToken.isEmpty {
                print("message \(String(describing: self.userinfo.message))")
            }
            else {
                UserInfoData.shared.SaveUserdata(info: self.userinfo)
                successCallback!(self.userinfo.mfa)
            }
            self.isLoading = true
        } onFailure: { (message) in
            self.message = message
            self.isLoading = true
            print("message \(message)")
        }
    }
}
