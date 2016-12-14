//
//  APIManager.swift
//  UppermostNews
//
//  Created by Cris on 12/4/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

enum getSourcesErrorHandler: Error {
    case failedToLoadData
}

class APIManager {
    static let shared: APIManager = APIManager()
    private init() {}
    
    func getSources(from: String, completion: @escaping ([NewsSources]?) -> Void) {
        guard let url: URL = URL(string: from) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("ERROR: \(getSourcesErrorHandler.failedToLoadData)")
            }
            
            if let responseCode = response as? HTTPURLResponse {
                print("getSources: \(responseCode.statusCode)")
            }
            guard let validData = data else { return }
            
            do {
                let sourceJSON = try JSONSerialization.jsonObject(with: validData, options: [])
                guard let sources = sourceJSON as? [String : Any] else { return }
                if let parsedSources = self.parseJSON(json: sources) {
                    completion(parsedSources)
                }
            }
            catch {
                print("ERROR ")
            }
            }.resume()
    }
    
    func parseJSON(json: [String : Any]) -> [NewsSources]? {
        guard let source = json["sources"] as? [[String : Any]] else { return nil}
        var parsedSources = [NewsSources]()
        source.forEach { (sourceObject) in
            guard let returnparsed = NewsSources(from: sourceObject) else { return }
            parsedSources.append(returnparsed)
        }
        return parsedSources
    }
    
    
    func getData(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url: URL = URL(string: urlString) else { return }
        let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                print("ERROR: \(error?.localizedDescription)")
            }
            
            if let validData = data {
                completion(validData)
            }
        }.resume()
    }
    
}
