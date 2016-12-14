//
//  GetImage.swift
//  UppermostNews
//
//  Created by Cris on 12/5/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation
import UIKit

class GetImage {
    static let shared: GetImage = GetImage()
    private init() {}
    
    public func getImage(urlString: String, completion: @escaping (UIImage?) -> Void ) {
        guard let url: URL = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil {
                print("\(error?.localizedDescription)")
            }
            guard let validData = data,
                let image = UIImage(data: validData) else { completion(nil); return }
            DispatchQueue.main.async {
                completion(image)
            }
            }.resume()
    }
    
}
