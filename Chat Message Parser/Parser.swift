//
//  Parser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

protocol Parser {
    
    var internalExpression: NSRegularExpression? { get set }
    var pattern: String { get }
    
    init()
    func matches(in string: String) -> [AnyObject]
    
}

extension Parser {
    
    func matches(in string: String) -> [AnyObject] {
        guard let internalExpression = self.internalExpression else { return [] }
        let matches = internalExpression.matches(in: string, range: NSMakeRange(0, string.characters.count))
        return values(in: string, for: matches) as [AnyObject]
    }
    
    internal func values(in string: String, for matches: [NSTextCheckingResult]) -> [String] {
        return matches.map {
            return (string as NSString).substring(with: $0.range)
        }
    }

}
