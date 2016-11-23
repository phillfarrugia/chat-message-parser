//
//  ChatMessage.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

enum MessageDataType {
    case Mentions
    case Emoticons
    case Links
    
    var title: String {
        switch (self) {
        case .Mentions:
            return "mentions"
        case .Emoticons:
            return "emoticons"
        case .Links:
            return "links"
        }
    }
}

class ChatMessage {
    
    private let message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    func parse(_ dataTypes: [MessageDataType]) -> [String: [AnyObject]] {
        var results: [String: [AnyObject]] = [:]
        for dataType in dataTypes {
            switch (dataType) {
            case .Mentions:
                if let matches = resolve(parser: MessageParser(), for: message) {
                    results[dataType.title] = matches
                }
            case .Emoticons:
                if let matches = resolve(parser: EmoticonParser(), for: message) {
                    results[dataType.title] = matches
                }
            case .Links:
                if let matches = resolve(parser: LinkParser(), for: message) {
                    results[dataType.title] = matches
                }
            }
        }
        return results
    }
    
    func resolve<T: Parser>(parser: T, for string: String) -> [AnyObject]? {
        let matches = parser.findMatches(in: string)
        if (matches.count > 0) {
            return matches
        }
        return nil
    }
    
}
