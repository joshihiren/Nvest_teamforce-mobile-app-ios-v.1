//
//  LoginService.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import Foundation
import SwiftyJSON
import RxSwift


class WebService {
    
    let rxbag = DisposeBag()
    
    public func LoginService(parameters: [String: Any],
                             onSuccess successCallback: ((_ response: [LoginRootClass]) -> Void)?,
                             onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        let url = String.init(format: "%@", API_Services.LoginAPI.ServiceFunctions())
        print("Calling Api:\(url)")
        
        ApiClient.shared.createRequest(url, method: .post, headers: ["Content-Type": "application/json"], parameters: parameters) { (responseObject: JSON) -> Void in
            var data = [LoginRootClass]()
            data.append(LoginRootClass.init(fromJson: responseObject))
            UserInfoData.shared.SaveUserdata(info: data.first!)
            successCallback?(data)
        } onFailure: { (errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
        
    }
    
    public func RxLoginService(parameters: [String: Any],
                               onSuccess successCallback: ((_ response: [LoginRootClass]) -> Void)?,
                               onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        
        let url = String.init(format: "%@", API_Services.LoginAPI.ServiceFunctions())
        print("Calling Api:\(url)")
        
        RRAPIRxManager.init(apiUrl: url, httpMethod: .post, param: parameters, showingIndicator: true)
            /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
            .subscribeConcurrentBackgroundToMainThreads()
            .subscribe(onNext: { responseObject in
                print(responseObject)
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                    // here "jsonData" is the dictionary encoded in JSON data
                    
                    let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                    // here "decoded" is of type `Any`, decoded from JSON data
                    
                    let dictFromJSON = JSON.init(rawValue: decoded)
                    // you can now cast it with the right type
                    var data = [LoginRootClass]()
                    data.append(LoginRootClass.init(fromJson: dictFromJSON))
                    UserInfoData.shared.SaveUserdata(info: data.first!)
                    successCallback?(data)
                } catch {
                    print(error.localizedDescription)
                    failureCallback?("")
                }
            }, onError: { error in
                print(error)
                failureCallback?("")
            }).disposed(by: rxbag)
    }
    
    public func ApplistingService(app: String, isRXmode: Bool = true,
                                  onSuccess successCallback: ((_ response: [AppListRootClass]) -> Void)?,
                                  onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@?app_code=%@", API_Services.AppListAPI.ServiceFunctions(),app)
        print("Calling Api:\(url)")
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .get, param: nil, showingIndicator: true)
                /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [AppListRootClass]()
                        data.append(AppListRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
        }
        else {
            ApiClient.shared.createRequest(url, method: .get, headers: ["Content-Type": "application/json"], parameters: [:]) { (responseObject: JSON) -> Void in
                var data = [AppListRootClass]()
                data.append(AppListRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
    
    func registerAppsAPI(email: String, isRXmode: Bool = true,
                         onSuccess successCallback: ((_ response: [RegisterAppRootClass]) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@%@", API_Services.registerAppsAPI.ServiceFunctions(), email)
        print("Calling Api:\(url)")
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .get, param: nil, showingIndicator: true)
                /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [RegisterAppRootClass]()
                        data.append(RegisterAppRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
        }
        else {
            ApiClient.shared.createRequest(url, method: .get, headers: ["Content-Type": "application/json"], parameters: [:]) { (responseObject: JSON) -> Void in
                var data = [RegisterAppRootClass]()
                data.append(RegisterAppRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
    
    func getcurrencydata(appcode: String, appprofile: String, isRXmode: Bool = true,
                         onSuccess successCallback: ((_ response: [CurrencyRootClass]) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@", API_Services.CurrencyAPI.ServiceFunctions())
        let body: [String: Any] = [
            "app_code": appcode
//            ,"profile_id": UserInfoData.shared.userinfo(infotype: .profile)
            ,"profile_id": appprofile
        ]
        print("Calling Api:\(url)")
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .post, param: body, showingIndicator: true)
                /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [CurrencyRootClass]()
                        data.append(CurrencyRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
            
        }
        else {
            ApiClient.shared.createRequest(url, method: .post, headers: ["Content-Type": "application/json"], parameters: body) { (responseObject: JSON) -> Void in
                var data = [CurrencyRootClass]()
                data.append(CurrencyRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
    
    func vaultTransfer(param: VaultTransferParam, isRXmode: Bool = true,
                       onSuccess successCallback: ((_ response: [VaultTransferRootClass]) -> Void)?,
                       onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@", API_Services.TranferAPI.ServiceFunctions())
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .post, param: param.description, showingIndicator: true)
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [VaultTransferRootClass]()
                        data.append(VaultTransferRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
        }
        else {
            ApiClient.shared.createRequest(url, method: .post, headers: ["Content-Type": "application/json"], parameters: param.description) { (responseObject: JSON) -> Void in
                var data = [VaultTransferRootClass]()
                data.append(VaultTransferRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
    
    func convertcurrency(appcode: String, appprofile: String, isRXmode: Bool = true,
                         onSuccess successCallback: ((_ response: [CurrencyRootClass]) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@", API_Services.CurrencyConvertAPI.ServiceFunctions())
        let body: [String: Any] = [
            "app_code": appcode
//            ,"profile_id": UserInfoData.shared.userinfo(infotype: .profile)
            ,"profile_id": appprofile
        ]
        print("Calling Api:\(url)")
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .post, param: body, showingIndicator: true)
                /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [CurrencyRootClass]()
                        data.append(CurrencyRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
            
        }
        else {
            ApiClient.shared.createRequest(url, method: .post, headers: ["Content-Type": "application/json"], parameters: body) { (responseObject: JSON) -> Void in
                var data = [CurrencyRootClass]()
                data.append(CurrencyRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
    
    func reciepientcall(email: String, isRXmode: Bool = true,
                         onSuccess successCallback: ((_ response: [ReciepientRootClass]) -> Void)?,
                         onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        let url = String.init(format: "%@%@", API_Services.ReciepientUserAPI.ServiceFunctions(), email)
        print("Calling Api:\(url)")
        if isRXmode {
            RRAPIRxManager.init(apiUrl: url, httpMethod: .get, param: nil, showingIndicator: true)
                /*.delaySubscription(.seconds(5), scheduler: RXScheduler.concurrentBackground)*/
                .subscribeConcurrentBackgroundToMainThreads()
                .subscribe(onNext: { responseObject in
                    print(responseObject)
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: responseObject, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data
                        
                        let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                        // here "decoded" is of type `Any`, decoded from JSON data
                        
                        let dictFromJSON = JSON.init(rawValue: decoded)
                        // you can now cast it with the right type
                        var data = [ReciepientRootClass]()
                        data.append(ReciepientRootClass.init(fromJson: dictFromJSON))
                        successCallback?(data)
                    } catch {
                        print(error.localizedDescription)
                    }
                }, onError: { error in
                    print(error)
                }).disposed(by: rxbag)
        }
        else {
            ApiClient.shared.createRequest(url, method: .get, headers: ["Content-Type": "application/json"], parameters: [:]) { (responseObject: JSON) -> Void in
                var data = [ReciepientRootClass]()
                data.append(ReciepientRootClass.init(fromJson: responseObject))
                successCallback?(data)
            } onFailure: { (errorMessage: String) -> Void in
                failureCallback?(errorMessage)
            }
        }
    }
}
