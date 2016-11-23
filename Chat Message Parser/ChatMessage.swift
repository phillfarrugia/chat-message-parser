//
//  ChatMessage.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

class ChatMessage {
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    func parse(_ dataTypes: [MessageDataType]) -> [String: [AnyObject]] {
        var results: [String: [AnyObject]] = [:]
        for dataType in dataTypes {
            if let matches = resolve(parser: dataType.parser, for: message) {
                results[dataType.title] = matches
            }
        }
        return results
    }
    
    func resolve(parser: Parser, for string: String) -> [AnyObject]? {
        let matches = parser.matches(in: string)
        if (matches.count > 0) {
            return matches
        }
        return nil
    }
    
}
