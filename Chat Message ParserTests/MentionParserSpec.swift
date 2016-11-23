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
    override func spec() {
        
        describe("matches in string") {
            
            context("valid regular expression", {
                
                context("input contains matches", {
                    it("should return an array of matches", closure: {
                        //
                    })
                })
                
                context("input doesn't contains matches", {
                    it("should return an empty array", closure: {
                        //
                    })
                })
                
            })
            
            context("invalid regular expression", {
                
                it("should return an empty array", closure: { 
                    //
                })
                
            })
            
        }
        
        describe("values in string for matches") {
            //
        }
        
    }
}
