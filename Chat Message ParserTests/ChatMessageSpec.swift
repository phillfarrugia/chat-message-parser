//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class ChatMessageSpec: QuickSpec {
    
    override func spec() {
        
        describe("parse data types", {
            
            it("should parse matches for a single data type", closure: {
                let result = ChatMessage("@phill").parse([.Mentions])
                let data = result.data(using: String.Encoding.utf8)!
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                    expect(jsonDict).toNot(beNil())
                    expect(jsonDict["mentions"]).to(equal(["phill"]))
                }
                catch _ { }
            })
            
            it("should parse matches for multiple data types", closure: {
                let result = ChatMessage("@phill @jack @johnathen").parse([.Mentions])
                let data = result.data(using: String.Encoding.utf8)!
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                    expect(jsonDict).toNot(beNil())
                    expect(jsonDict["mentions"]).to(equal(["phill", "jack", "johnathen"]))
                }
                catch _ { }
            })
            
        })
        
        describe("resolve parser for string", {
            
            it("should return matches from associated data type parser", closure: {
                
            })
            
            it("should return nil if no matches for data type", closure: {
                
            })
            
        })
        
        describe("serialize dictionary", {
            
            it("should serialize a dictionary into a valid json string", closure: {
                
            })
            
            it("should return an empty string if serialization fails", closure: {
                
            })
            
        })
        
    }
}
