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
    
    private struct Constants {
        
        static let timeout: TimeInterval = 10
        static let artistName = "Cher"
        static let artistId = "bfcc6d75-a6a5-4bc6-8282-47aec8531818"
        static let albumId = "63b3a8ca-26f2-4e2b-b867-647a6ec2bebd"
        
    }
    
    override func spec() {
        describe("APIManager") {
            let sut = APIManager(requester: Requester())
            
            context("Search of artist") {
                it("should successfully return non-empty collection of artist entities") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.searchArtist(name: Constants.artistName) { response in
                            expect(response.value).toNot(beEmpty())
                            done()
                        }
                    }
                }
            }
            
            context("Top albums") {
                it("should successfully return non-empty collection of album entities") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.topAlbums(artistId: Constants.artistId) { response in
                            expect(response.value).toNot(beEmpty())
                            done()
                        }
                    }
                }
            }
            
            context("Album info") {
                it("should successfully retrieve the album info") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.albumInfo(albumId: Constants.albumId) { response in
                            expect(response.value).toNot(beNil())
                            done()
                        }
                    }
                }
            }
        }
    }
    
}
