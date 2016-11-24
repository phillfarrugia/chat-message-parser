//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class MentionParserSpec: QuickSpec {
    
    let mentionParser = MentionParser()
    
    override func spec() {
        
        describe("matches in string") {
            it("should match a mention starting with an @ symbol", closure: {
                expect(self.mentionParser.matches(in: "@chris you around?") as? [String]).to(equal(["chris"]))
                expect(self.mentionParser.matches(in: "@phill22 you around?") as? [String]).to(equal(["phill22"]))
                expect(self.mentionParser.matches(in: "where is @melissa") as? [String]).to(equal(["melissa"]))
            })
            
            it("should end when hitting a non-word character", closure: {
                expect(self.mentionParser.matches(in: "where is @melissa?") as? [String]).to(equal(["melissa"]))
                expect(self.mentionParser.matches(in: "what about @phill, is he coming?") as? [String]).to(equal(["phill"]))
                expect(self.mentionParser.matches(in: "go @chris!") as? [String]).to(equal(["chris"]))
            })
            
            it("should match multiple mentions", closure: {
                expect(self.mentionParser.matches(in: "@phill @chris @jack") as? [String]).to(equal(["phill", "chris", "jack"]))
                expect(self.mentionParser.matches(in: "waiting for @jack and @jill") as? [String]).to(equal(["jack", "jill"]))
            })
            
            it("should not match if no mentions", closure: {
                expect(self.mentionParser.matches(in: "") as? [String]).to(equal([]))
                expect(self.mentionParser.matches(in: "a lot of words but no mentions here") as? [String]).to(equal([]))
                expect(self.mentionParser.matches(in: "is it @ the cafe?") as? [String]).to(equal([]))
            })
        }
        
        describe("sanitize values", closure: {
            it("should remove @ symbols from strings if exist", closure: {
                expect(self.mentionParser.sanitize(values: ["@chris"])).to(equal(["chris"]))
                expect(self.mentionParser.sanitize(values: ["@phill22"])).to(equal(["phill22"]))
                expect(self.mentionParser.sanitize(values: ["@meli12ssa"])).to(equal(["meli12ssa"]))
            })
            
            it("should return not modify string if no @ symbols", closure: {
                expect(self.mentionParser.sanitize(values: ["chris"])).to(equal(["chris"]))
                expect(self.mentionParser.sanitize(values: ["phill22"])).to(equal(["phill22"]))
                expect(self.mentionParser.sanitize(values: ["meli12ssa"])).to(equal(["meli12ssa"]))
            })
        })
        
    }
}
