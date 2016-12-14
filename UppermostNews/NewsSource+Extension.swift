//
//  NewsSource+Extension.swift
//  UppermostNews
//
//  Created by Cris on 12/14/16.
//  Copyright © 2016 Cris. All rights reserved.
//

import Foundation

extension NewsSource {
    func populate(from: [String : Any]) {
        guard let id = from["id"] as? String,
            let name = from["name"] as? String,
            let category = from["category"] as? String,
            let logoDict = from["urlsToLogos"] as? [String : Any],
            let logo = logoDict["small"] as? String   else { return }
            let description = from["description"] as? String ?? ""
        self.sourceID = id
        self.sourceName = name
        self.category = category
        self.sourceLogo = logo
        self.sourceDescription = description
    }
    
}
