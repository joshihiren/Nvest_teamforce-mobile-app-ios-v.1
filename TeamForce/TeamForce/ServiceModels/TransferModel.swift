//
//  TransferModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 11/02/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class TransferModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var Service: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var dataObject: VaultTransferRootClass = VaultTransferRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }

    func vaulttransferAPI(param: VaultTransferParam, successCallback: ((_ isStatus: Bool) -> Void)?) {
        Service.vaultTransfer(param: param, isRXmode: true) { (responseObject) in
            self.dataObject = responseObject.first!
            if self.dataObject.data.count != 0 && self.dataObject.status {
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
