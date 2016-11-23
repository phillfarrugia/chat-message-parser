//
//  MessageDataType.swift
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
    
    var parser: Parser {
        switch (self) {
        case .Mentions:
            return MentionParser()
        case .Emoticons:
            return EmoticonParser()
        case .Links:
            return LinkParser()
        }
    }
}
