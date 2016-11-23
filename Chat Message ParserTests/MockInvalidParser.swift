//
//  MockInvalidParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct MockInvalidParser: Parser {
    
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = "\thisIsAnInvalidRegexPattern/\\"
    
    init() {
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch _ { }
    }
    
}
