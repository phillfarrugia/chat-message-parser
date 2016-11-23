//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class EmoticonParserSpec: QuickSpec {
    
    let emoticonParser = EmoticonParser()
    
    override func spec() {
        
        describe("matches in string") {
            it("should match alphanumeric strings contained in parenthesis", closure: {
                expect(self.emoticonParser.matches(in: "(coffee)") as? [String]).to(equal(["coffee"]))
                expect(self.emoticonParser.matches(in: "Good morning! (megusta)") as? [String]).to(equal(["megusta"]))
                expect(self.emoticonParser.matches(in: "(que123)") as? [String]).to(equal(["que123"]))
            })
            
            it("should not match strings longer than 15 characters", closure: {
                expect(self.emoticonParser.matches(in: "(this is wayyyyyy more than 15 characters)") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "(aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa)") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "(123456789101112131415)") as? [String]).to(equal([]))
            })
            
            it("should not stop when hitting non-word characters", closure: {
                expect(self.emoticonParser.matches(in: "(words with spaces in between") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "explain something (inside parenthesis for side notes)") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "(1234 5678 9101112)") as? [String]).to(equal([]))
            })
            
            it("should match multiple emoticons", closure: {
                expect(self.emoticonParser.matches(in: "Good morning! (megusta) (coffee)") as? [String]).to(equal(["megusta", "coffee"]))
                expect(self.emoticonParser.matches(in: "(hello) (goodbye) (nice) (100)") as? [String]).to(equal(["hello", "goodbye", "nice", "100"]))
                expect(self.emoticonParser.matches(in: "(wave) Welcome (smile)") as? [String]).to(equal(["wave", "smile"]))
            })
            
            it("should not match if no emoticons", closure: {
                expect(self.emoticonParser.matches(in: "") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "a lot of words but no emoticons here") as? [String]).to(equal([]))
                expect(self.emoticonParser.matches(in: "(I don't think that I like it though)") as? [String]).to(equal([]))
            })
        }
        
    }
}
