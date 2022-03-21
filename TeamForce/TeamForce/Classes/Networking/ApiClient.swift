//
//  ApiClient.swift
//  TeamForce
//
//  Created by Hiren Joshi on 19/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON
import RxCocoa
import RxSwift

class ApiClient {
    static let shared = ApiClient()

    func createRequest(
        _ url: String,
        method: HTTPMethod,
        headers: [String: String]?,
        parameters: [String: Any]?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?
    ) {
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: HTTPHeaders.init(headers!)).validate().responseJSON { AFdata in
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON object")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                    switch AFdata.result {
                    case .success(let value):
                        let json = JSON(value)
                        successCallback?(json)
                    case .failure(let error):
                        if (error as NSError).code == StatusCode.badRequest.rawValue {
                            UserInfoData.shared.UserLogout {
                                AppScene.SetLoginVC()
                            }
                        }
                        if let callback = failureCallback {
                            callback(error.localizedDescription)
                        }
                    }
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    return
                }
            }
//        AF.request(url, method: method).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                successCallback?(json)
//            case .failure(let error):
//                if let callback = failureCallback {
//                    callback(error.localizedDescription)
//                }
//            }
//        }
    }
    
}
