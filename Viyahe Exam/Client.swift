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
        #if STAGING
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

    func get(userWithCompletion completion: @escaping (_ userModels:[UserModel]?)->()) {
        
        alamofireManager.request(baseURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { (response) in
                
                switch response.result {
                case .success(_ ):
                    if let data = response.data {
                        if let models = try? JSONDecoder().decode([UserModel].self, from: data) {
                            completion(models)
                        } else {
                            // decode error here
                            completion(nil)
                        }
                    } else {
                        // decode error here
                        completion(nil)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }

}

