//
//  ReciepientModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 15/02/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class ReciepientModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var Service: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var dataObject: ReciepientRootClass = ReciepientRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }

    func reciepientAPI(email: String, successCallback: ((_ isStatus: Bool) -> Void)?) {
        Service.reciepientcall(email: email) { (responseObject) in
            self.dataObject = responseObject.first!
            if !(self.dataObject.users.first?.userData.username.isEmpty)! && self.dataObject.status {
                successCallback!(true)
            }
            else {
                successCallback!(false)
            }
            self.isLoading = true
        } onFailure: { (message) in
            self.message = message
            self.isLoading = true
            successCallback!(false)
        }

    }
    
}
