//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class ParserSpec: QuickSpec {
    
    let invalidParser = MockInvalidParser()
    let validParser = MockValidParser()
    
    override func spec() {
        
        describe("matches in string") {
            context("valid regular expression", {
                context("input contains matches", {
                    it("should return an array containing a single match", closure: {
                        expect(self.validParser.internalExpression).toNot(beNil())
                        expect(self.validParser.matches(in: "&sample").count).to(equal(1))
                    })
                    
                    it("should return an array containing multiple matches", closure: {
                        expect(self.validParser.internalExpression).toNot(beNil())
                        expect(self.validParser.matches(in: "&sample &sample").count).to(equal(2))
                        expect(self.validParser.matches(in: "&sample &test &hello").count).to(equal(3))
                        expect(self.validParser.matches(in: "&one &two &three &four").count).to(equal(4))
                    })
                })
                
                context("input doesn't contains matches", {
                    it("should return an empty array", closure: {
                        expect(self.validParser.matches(in: "no matches here").count).to(equal(0))
                        expect(self.validParser.matches(in: "").count).to(equal(0))
                        expect(self.validParser.matches(in: "    ").count).to(equal(0))
                    })
                })
                
            })
            
            context("invalid regular expression", {
                it("should return an empty array", closure: {
                    expect(self.invalidParser.internalExpression).to(beNil())
                    expect(self.invalidParser.matches(in: "sample input string").count).to(equal(0))
                    expect(self.invalidParser.matches(in: "@mention @name @sample").count).to(equal(0))
                    expect(self.invalidParser.matches(in: "\thisIsAnInvalidRegexPattern/\\").count).to(equal(0))
                })
            })
        }
        
        describe("values in string for matches") {
            it("should map NSTextCheckingResults into correct string values", closure: {
                let sampleString = "this is an &sample"
                let matchResults = self.validParser.internalExpression?.matches(in: sampleString, range: NSMakeRange(0, sampleString.characters.count))
                expect(self.validParser.values(in: sampleString, for: matchResults!)).to(equal(["&sample"]))
            })

            it("should handle NSTextCheckingResults not contained in string", closure: {
                let sampleString = "this is an &sample"
                let matchResults = self.validParser.internalExpression?.matches(in: sampleString, range: NSMakeRange(0, sampleString.characters.count))
                expect(self.validParser.values(in: "not", for: matchResults!)).to(equal([]))
            })
        }
        
    }
}
