//
//  MessageParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct MentionParser: Parser {
    
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = "@\\w+"
    
    init() {
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch let error {
            print("\(error)")
        }
    }
    
    func sanitize(values: [String]) -> [String] {
        return values.map {
            return $0.replacingOccurrences(of: "@", with: "")
        }
    }
    
}
