//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class HTMLParserSpec: QuickSpec {
    
    let invalidHTMLParser = HTMLParser()
    let validHTMLParser = HTMLParser(tag: "sample")
    
    override func spec() {
        
        describe("matches in string") {
            
            context("no tag provided", closure: { 
                it("should return an empty array", closure: {
                    expect(self.invalidHTMLParser.internalExpression).to(beNil())
                    expect(self.invalidHTMLParser.matches(in: "<sample>value</sample>").count).to(equal(0))
                })
            })
            
            context("tag provided", closure: {
                
                context("tag exists in input", closure: {
                    it("should return the inner value", closure: {
                        expect(self.validHTMLParser.matches(in: "<sample>value</sample>") as? [String]).to(equal(["value"]))
                        expect(self.validHTMLParser.matches(in: "<sample>test</sample><random2>test2</random2>") as? [String]).to(equal(["test"]))
                        expect(self.validHTMLParser.matches(in: "<one>two</one><sample>value</sample>") as? [String]).to(equal(["value"]))
                    })
                })
                
                context("tag doesn't exist in input", closure: {
                    it("should return an empty array", closure: {
                        expect(self.validHTMLParser.matches(in: "<one>two</one>") as? [String]).to(equal([]))
                        expect(self.validHTMLParser.matches(in: "<one>two</one><title>value</title>") as? [String]).to(equal([]))
                        expect(self.validHTMLParser.matches(in: "<one>two</one><title>value</title><sampl>value</sampl>") as? [String]).to(equal([]))
                    })
                })
                
            })
        }
        
        describe("sanitize values", closure: {
            it("should remove parenthesis symbols from strings if exist", closure: {
                expect(self.validHTMLParser.sanitize(values: ["<sample>one</sample>"])).to(equal(["one"]))
            })
            
            it("should return not modify string if no parenthesis symbols", closure: {
                expect(self.validHTMLParser.sanitize(values: ["one"])).to(equal(["one"]))
            })
        })
        
    }
}
