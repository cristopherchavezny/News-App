//
//  NewsSources.swift
//  UppermostNews
//
//  Created by Cris on 12/4/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

class NewsSources {
    let sourceID: String
    let sourceName: String
    let sourceDescription: String
    let category: String
    let sourceLogo: String
    
    init(sourceID: String, sourceName: String, sourceDescription: String, category: String, sourceLogo: String) {
        self.sourceID = sourceID
        self.sourceName = sourceName
        self.sourceDescription = sourceDescription
        self.category = category
        self.sourceLogo = sourceLogo
    }
    
    convenience init?(from json: [String : Any]) {
        guard let id = json["id"] as? String,
            let name = json["name"] as? String,
            let category = json["category"] as? String,
            let logoDict = json["urlsToLogos"] as? [String : Any],
            let logo = logoDict["small"] as? String   else { return nil }
        
        let description = json["description"] as? String ?? ""
        
        self.init(sourceID: id, sourceName: name, sourceDescription: description, category: category, sourceLogo: logo)
    }
}
