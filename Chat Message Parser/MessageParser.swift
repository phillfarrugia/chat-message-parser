//
//  MessageParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct MessageParser: Parser {
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = "@\\w+"
    
    init() {
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch let error {
            print("\(error)")
        }
    }
    
    func findMatches(in string: String) -> [AnyObject] {
        guard let internalExpression = self.internalExpression else { return [] }
        let matches = internalExpression.matches(in: string, range: NSMakeRange(0, string.characters.count))
        return values(in: string, for: matches) as [AnyObject]
    }
    
}
