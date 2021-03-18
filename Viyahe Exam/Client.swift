//
//  Client.swift
//  Viyahe Exam
//
//  Created by Tristan Angelo Galang on 3/17/21.
//

import Foundation
import Alamofire

class Client {
    
    /// Singleton for Client
    static let shared = Client()
    
    /// Base UrL
    var baseURL:String {
        #if DEBUGDEV
        return "https://api.github.com/users"
        #else
        return "https://api.github.com/users"
        #endif
    }

    /// Alamofire Manager
    var alamofireManager: Session = {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 30
        configuration.timeoutIntervalForRequest = 30
        
        let alamofireManager = Alamofire.Session(configuration: configuration,
                                                 delegate: SessionDelegate(),
                                                 rootQueue: DispatchQueue(label: "org.alamofire.session.rootQueue"),
                                                 startRequestsImmediately: true,
                                                 requestQueue: nil,
                                                 serializationQueue: nil,
                                                 interceptor: nil,
                                                 serverTrustManager: nil,
                                                 redirectHandler: nil,
                                                 cachedResponseHandler: nil,
                                                 eventMonitors: [])
        return alamofireManager
    }()
    
    // Private Init
    private init() {}

    func get(userWithCompletion completion: @escaping (_ userModels:[UserModel]?, _ error: ErrorLimitModel?)->()) {
        
        alamofireManager.request(baseURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(_ ):
                    if let data = response.data {
                        if let models = try? JSONDecoder().decode([UserModel].self, from: data) {
                            completion(models, nil)
                        } else if let model = try? JSONDecoder().decode(ErrorLimitModel.self, from: data) {
                            // decode error here
                            completion(nil, model)
                        }
                    } else {
                        // decode error here
                        completion(nil, ErrorLimitModel(message: "Unable to decode.", documentationURL: nil))
                    }
                case .failure(let error):
                    completion(nil, ErrorLimitModel(message: error.localizedDescription, documentationURL: nil))
                }
            }
    }
    
    func get(userDetail loginName:String,
             WithCompletion completion: @escaping (_ userModels:UserModel?, _ error: ErrorLimitModel?)->()) {
        
        let url = baseURL + "/\(loginName)"
        
        alamofireManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(_ ):
                    if let data = response.data {
                        if let model = try? JSONDecoder().decode(UserModel.self, from: data) {
                            completion(model, nil)
                        } else if let model = try? JSONDecoder().decode(ErrorLimitModel.self, from: data) {
                            // decode error here
                            completion(nil, model)
                        }
                    } else {
                        // decode error here
                        completion(nil, ErrorLimitModel(message: "Unable to decode.", documentationURL: nil))
                    }
                case .failure(let error):
                    completion(nil, ErrorLimitModel(message: error.localizedDescription, documentationURL: nil))
                }
            }
    }

}

