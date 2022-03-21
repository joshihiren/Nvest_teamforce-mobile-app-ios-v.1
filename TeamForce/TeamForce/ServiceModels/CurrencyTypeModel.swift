//
//  CurrencyTypeModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 08/02/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit


class CurrencyTypeModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var Service: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var dataObject: CurrencyRootClass = CurrencyRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }

    func getcurrencylist(appcode: String, appprofile: String, successCallback: ((_ isStatus: Bool) -> Void)?) {
        Service.getcurrencydata(appcode: appcode, appprofile: appprofile) { (responseObject) in
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

