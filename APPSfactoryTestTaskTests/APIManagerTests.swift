//
//  APIManagerTests.swift
//  APPSfactoryTestTaskTests
//
//  Created by Alexander Snegursky on 13/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Quick
import Nimble

@testable import APPSfactoryTestTask

final class APIManagerTests: QuickSpec {
    
    override func spec() {
        describe("APIManager") {
            let sut = APIManager(requester: Requester())
            
            context("Search of artist") {
                it("should successfully perform the search artist request") {
                    waitUntil(timeout: 10) { done in
                        sut.searchArtist(name: "Cher") { response in
                            expect(response.isSuccess).to(beTrue())
                            done()
                        }
                    }
                }
                
                it("should successfully return non-empty collection of artist entities") {
                    waitUntil(timeout: 10) { done in
                        sut.searchArtist(name: "Cher") { response in
                            expect(response.value).toNot(beEmpty())
                            done()
                        }
                    }
                }
            }
        }
    }
    
}
