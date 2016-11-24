//
//  XMLParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 24/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct HTMLParser: Parser {
    
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = ""
    internal var tag: String?
    
    init() { }
    
    init(tag: String) {
        self.tag = tag
        self.pattern = "<\(tag)>(.*?)</\(tag)>"
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch let error {
            print("\(error)")
        }
    }
    
    func sanitize(values: [String]) -> [String] {
        guard let tag = self.tag else { return values }
        return values.map {
            return $0.replacingOccurrences(of: "<\(tag)>", with: "").replacingOccurrences(of: "</\(tag)>", with: "")
        }
    }
    
}
