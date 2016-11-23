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
    func values(in string: String, for matches: [NSTextCheckingResult]) -> [String]
    func sanitize(values: [String]) -> [String]
}

extension Parser {
    
    func matches(in string: String) -> [AnyObject] {
        guard let internalExpression = self.internalExpression else { return [] }
        let matches = internalExpression.matches(in: string, range: NSMakeRange(0, string.characters.count))
        return sanitize(values: values(in: string, for: matches)) as [AnyObject]
    }
    
    internal func values(in string: String, for matches: [NSTextCheckingResult]) -> [String] {
        return matches.map {
            if ($0.range.location + $0.range.length <= string.characters.count) {
                return (string as NSString).substring(with: $0.range)
            }
            return nil
        }.flatMap { $0 }
    }
    
    internal func sanitize(values: [String]) -> [String] {
        return values
    }

}
