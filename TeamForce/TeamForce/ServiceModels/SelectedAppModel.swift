//
//  SelectedAppModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 05/02/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class SelectedAppModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var ApplistService: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var dataObject: RegisterAppRootClass = RegisterAppRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }
    
    func selectedApplist(email: String = UserInfoData.shared.userinfo(infotype: .email), successCallback: ((_ isStatus: Bool) -> Void)?) {
        ApplistService.registerAppsAPI(email: email) { (responseObject) in
            self.dataObject = responseObject.first!
            if self.dataObject.count != 0 && self.dataObject.status {
                successCallback!(true)
            }
            self.isLoading = true
        } onFailure: { (message) in
            self.message = message
            self.isLoading = true
            print("message \(message)")
        }
    }
    
}

