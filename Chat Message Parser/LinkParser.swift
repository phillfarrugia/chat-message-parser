//
//  LinkParser.swift
//  Chat Message Parser
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Foundation

struct LinkParser: Parser {
    
    internal var internalExpression: NSRegularExpression?
    internal var pattern: String = "(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w\\.-]*)*\\/?"
    
    init() {
        do { self.internalExpression = try NSRegularExpression(pattern: pattern, options: .caseInsensitive) }
        catch let error {
            print("\(error)")
        }
    }
    
    func matches(in string: String) -> [AnyObject] {
        guard let internalExpression = self.internalExpression else { return [] }
        let matches = internalExpression.matches(in: string, range: NSMakeRange(0, string.characters.count))
        let urls = values(in: string, for: matches)
        return urls.map { ["url": $0, "title": title(for: $0)] } as [AnyObject]
    }
    
    private func title(for urlString: String) -> String? {
        if let url = URL(string: urlString) {
            do {
                let html = try NSString.init(contentsOf: url, encoding: String.Encoding.ascii.rawValue)
                if let titles = HTMLParser(tag: "title").matches(in: html as String) as? [String] {
                    return titles.first
                }
            }
            catch let error { print("\(error)") }
        }
        return nil
    }
    
}
