//
//  LinkParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct LinkParser: Parser {
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = "(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?"
    
    init() {
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch let error {
            print("\(error)")
        }
    }
    
}
