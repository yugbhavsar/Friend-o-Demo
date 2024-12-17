//
//  ApiProvider.swift
//  friendListDemo
//
//  Created by Techify on 18/12/24.
//

import Foundation


enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class ApiProivder {
    
    static let shared = ApiProivder()
    
    
    func request (_ httpMethod: HttpMethod = .get, param:[String:Any] ,setParamAsbody: Bool = false,completion:@escaping (([String:Any]) -> Void)) {
        
        let baseUri = ProcessInfo.processInfo.environment["baseUrl"] ?? ""
        
        guard let url = URL(string: baseUri) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        if setParamAsbody {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: param) else {
                return
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = httpBody
        }
        else{
            var urlComonent = URLComponents(url: url, resolvingAgainstBaseURL: true)
            urlComonent?.addQuery(parameter: param)
            request.url = urlComonent?.url
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let responseData = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments)
                var json : [String:Any] = [:]
                
                json = responseData as? [String:Any] ?? [:]
                completion(json)
                
            } catch let jsonError {
                print(jsonError)
                completion([:])
            }
        }
        task.resume()
    }
}


public extension URLComponents {
    /// Adds parameter as url queries
    /// - Parameter parameters: parameter to encode
    mutating func addQuery(parameter: [String:Any]){
        self.queryItems = self.queryItems ?? [] + parameter.map {
            if $0.1 is String{
                return URLQueryItem(name: $0.0, value: $0.1 as? String)
            }else{
                return URLQueryItem(name: String($0.0), value: String(describing: $0.1))
            }
        }
        .compactMap{$0}
    }
}
