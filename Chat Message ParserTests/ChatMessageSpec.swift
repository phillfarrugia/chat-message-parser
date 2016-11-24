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
            
            context("mentions", closure: { 
                it("should parse matches for a single mention", closure: {
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
                
                it("should not parse unspecified data types", closure: {
                    let result = ChatMessage("@phill @jack @johnathen (randomEmoji) http://google.com.au/").parse([.Mentions])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                        expect(jsonDict).toNot(beNil())
                        expect(jsonDict["mentions"]).toNot(beNil())
                        expect(jsonDict["emoticons"]).to(beNil())
                        expect(jsonDict["links"]).to(beNil())
                    }
                    catch _ { }
                })
            })
            
            context("emoticons", closure: {
                it("should parse matches for a single emoticon", closure: {
                    let result = ChatMessage("oh cool (cool)").parse([.Emoticons])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                        expect(jsonDict).toNot(beNil())
                        expect(jsonDict["emoticons"]).to(equal(["cool"]))
                    }
                    catch _ { }
                })
                
                it("should parse matches for multiple emoticons", closure: {
                    let result = ChatMessage("(wave) (hello)").parse([.Emoticons])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                        expect(jsonDict).toNot(beNil())
                        expect(jsonDict["emoticons"]).to(equal(["wave", "hello"]))
                    }
                    catch _ { }
                })
                
                it("should not parse unspecified data types", closure: {
                    let result = ChatMessage("@phill @jack @johnathen (randomEmoji) http://google.com.au/").parse([.Emoticons])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [String]]
                        expect(jsonDict).toNot(beNil())
                        expect(jsonDict["emoticons"]).toNot(beNil())
                        expect(jsonDict["mentions"]).to(beNil())
                        expect(jsonDict["links"]).to(beNil())
                    }
                    catch _ { }
                })
            })
            
            context("links", closure: {
                it("should parse matches for a single link", closure: {
                    let result = ChatMessage("http://google.com.au/").parse([.Links])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [[String: String]]]
                        expect(jsonDict).toNot(beNil())
                        
                        let links = jsonDict["links"]!
                        expect(links).toNot(beNil())
                        
                        let first = links[0]
                        expect(first).to(equal(["url": "http://google.com.au/", "title": "Google"]))
                    }
                    catch _ { }
                })
                
                it("should parse matches for multiple emoticons", closure: {
                    let result = ChatMessage("http://google.com.au/ https://atlassian.com/").parse([.Links])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: [[String: String]]]
                        expect(jsonDict).toNot(beNil())
                        
                        let links = jsonDict["links"]!
                        expect(links).toNot(beNil())
                        
                        let first = links[0]
                        let second = links[1]
                        expect(first).to(equal(["url": "http://google.com.au/", "title": "Google"]))
                        expect(second).to(equal(["url": "https://atlassian.com/", "title": "Atlassian | Software Development and Collaboration Tools"]))
                    }
                    catch _ { }
                })
                
                it("should not parse unspecified data types", closure: {
                    let result = ChatMessage("@phill @jack @johnathen (randomEmoji) http://google.com.au/").parse([.Links])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as!  [String: [[String: String]]]
                        expect(jsonDict).toNot(beNil())
                        expect(jsonDict["links"]).toNot(beNil())
                        expect(jsonDict["mentions"]).to(beNil())
                        expect(jsonDict["emoticons"]).to(beNil())
                    }
                    catch _ { }
                })
            })
            
            context("mentions, links and emoticons", closure: { 
                it("should parse matches for multiple data types", closure: {
                    let result = ChatMessage("@phill @jack @johnathen (randomEmoji) http://google.com.au/").parse([.Mentions, .Emoticons, .Links])
                    let data = result.data(using: String.Encoding.utf8)!
                    do {
                        let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as!  [String: [AnyObject]]
                        expect(jsonDict).toNot(beNil())
                        
                        let mentions = jsonDict["mentions"] as! [String]
                        expect(mentions).toNot(beNil())
                        expect(mentions).to(equal(["phill", "jack", "johnathen"]))
                        
                        let emoticons = jsonDict["emoticons"] as! [String]
                        expect(emoticons).toNot(beNil())
                        expect(emoticons).to(equal(["randomEmoji"]))
                        
                        let links = jsonDict["links"] as! [[String: String]]
                        let firstLink = links[0]
                        expect(links).toNot(beNil())
                        expect(firstLink).to(equal(["url": "http://google.com.au/", "title": "Google"]))
                    }
                    catch _ { }
                })
            })
            
        })
        
        describe("resolve parser for string", {
            
            it("should return matches from associated data type parser", closure: {
                let mockParser = MockValidParser()
                let result = ChatMessage.resolve(parser: mockParser, for: "&phill") as! [String]
                expect(result).to(equal(["&phill"]))
            })
            
            it("should return nil if no matches for data type", closure: {
                let mockParser = MockValidParser()
                expect(ChatMessage.resolve(parser: mockParser, for: "no matches in string")).to(beNil())
            })
            
        })
        
        describe("serialize dictionary", {
            
            it("should serialize a dictionary into a valid json string", closure: {
                let dict = ["serialize": ["this" as AnyObject]]
                let result = ChatMessage.serialize(dictionary: dict)!
                let data = result.data(using: String.Encoding.utf8)!
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as!  [String: [AnyObject]]
                    expect(jsonDict).toNot(beNil())
                    let serializeValue = jsonDict["serialize"] as! [String]
                    expect(serializeValue).to(equal(["this"]))
                }
                catch _ { }
            })
            
        })
        
    }
}
