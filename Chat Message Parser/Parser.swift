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
    func findMatches(in string: String) -> [AnyObject]
}

extension Parser {
    
    internal func values(in string: String, for matches: [NSTextCheckingResult]) -> [String] {
        return matches.map {
            return (string as NSString).substring(with: $0.range)
        }
    }

}
