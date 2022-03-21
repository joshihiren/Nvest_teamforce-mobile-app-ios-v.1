//
//  AppListModel.swift
//  TeamForce
//
//  Created by Hiren Joshi on 31/01/21.
//

import Foundation
import Combine
import SwiftUI
import UIKit

class AppListModel: ObservableObject {
    
    let willChange = PassthroughSubject<Void, Never>()
    private var ApplistService: WebService = WebService()
    
    @Published var isLoading = false
    @Published var message: String = String.init() {
        willSet {
            willChange.send()
        }
    }
    @Published var Applist: AppListRootClass = AppListRootClass.init(fromJson: []) {
        willSet {
            willChange.send()
        }
    }
    
    func AppListAPI(successCallback: ((_ isStatus: Bool) -> Void)?) {
        ApplistService.ApplistingService (app: "teamforce"){ (responseObject) in
            self.Applist = responseObject.first!
            if self.Applist.count != 0 {
                successCallback!(true)
            }
            self.isLoading = true
        } onFailure: { (errorMSG) in
            self.message = errorMSG
            self.isLoading = true
            print("message \(errorMSG)")
        }
    }
}
