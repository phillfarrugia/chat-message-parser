//
//  Chat_Message_ParserTests.swift
//  Chat Message ParserTests
//
//  Created by Phill Farrugia on 23/11/16.
//  Copyright © 2016 Phill Farrugia. All rights reserved.
//

import Quick
import Nimble

class LinkParserSpec: QuickSpec {
    
    let linkParser = LinkParser()
    
    override func spec() {
        
        describe("matches in string") {
            it("should match http links", closure: {
                if let result = self.linkParser.matches(in: "http://google.com.au/") as? [[String: String]] {
                    let first = result[0]
                    expect(first["url"]).to(equal("http://google.com.au/"))
                    expect(first["title"]).to(equal("Google"))
                }
            })
            
            it("should match multiple http links", closure: {
                if let result = self.linkParser.matches(in: "http://google.com.au/ https://atlassian.com/") as? [[String: String]] {
                    let first = result[0]
                    let second = result[1]
                    expect(first["url"]).to(equal("http://google.com.au/"))
                    expect(first["title"]).to(equal("Google"))
                    expect(second["url"]).to(equal("https://atlassian.com/"))
                    expect(second["title"]).to(equal("Atlassian | Software Development and Collaboration Tools"))
                }
            })
            
            it("should not match if no http links", closure: {
                if let result = self.linkParser.matches(in: "there are no urls in this message") as? [[String: String]] {
                    expect(result.count).to(equal(0))
                }
            })
        }
        
        describe("title for url string", closure: {
            it("should return the correct title for a url string", closure: {
                expect(self.linkParser.title(for: "http://google.com.au/")).to(equal("Google"))
                expect(self.linkParser.title(for: "https://atlassian.com/")).to(equal("Atlassian | Software Development and Collaboration Tools"))
                expect(self.linkParser.title(for: "http://www.nbcolympics.com/")).to(equal("2016 Rio Olympic Games | NBC Olympics"))
                expect(self.linkParser.title(for: "https://twitter.com/jdorfman/status/430511497475670016")).to(equal("Justin Dorfman on Twitter: &quot;nice @littlebigdetail from @HipChat (shows hex colors when pasted in chat). http://t.co/7cI6Gjy5pq&quot;"))
            })
            
            it("should return nil for an invalid url", closure: {
                expect(self.linkParser.title(for: "fakeURL")).to(beNil())
                expect(self.linkParser.title(for: "http://atlassian")).to(beNil())
                expect(self.linkParser.title(for: "http://sample/")).to(beNil())
            })
        })
        
    }
}
