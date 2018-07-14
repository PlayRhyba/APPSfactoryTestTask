//
//  AlbumStorageTests.swift
//  APPSfactoryTestTaskTests
//
//  Created by Alexander Snegursky on 14/07/2018.
//  Copyright © 2018 Alexander Snegursky. All rights reserved.
//

import Quick
import Nimble

@testable import APPSfactoryTestTask

final class AlbumStorageTests: QuickSpec {
    
    private struct Constants {
        
        static let timeout: TimeInterval = 2
        
    }
    
    override func spec() {
        describe("AlbumStorage") {
            let testData = AlbumStorageTests.makeAlbum()
            var sut: AlbumStorage!
            
            context("Adding") {
                beforeEach {
                    sut = AlbumStorage.shared
                    
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.load { _ in done() }
                    }
                }
                
                it("should successfully add album") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.add(album: testData) { result in
                            expect(result.isSuccess).to(beTrue())
                            done()
                        }
                    }
                }
                
                it("should correctly initialize added album's info") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.add(album: testData) { result in
                            let expected = [testData.artist,
                                            testData.mbid,
                                            testData.name,
                                            testData.image.imageURL(size: .mega)?.absoluteString ?? ""]
                            
                            let actual = [result.value?.artist ?? "",
                                          result.value?.mbid ?? "",
                                          result.value?.title ?? "",
                                          result.value?.imageURL ?? ""]
                            
                            expect(actual).to(equal(expected))
                            
                            done()
                        }
                    }
                }
                
                it("should correctly initialize added album's tracks") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.add(album: testData) { result in
                            let expected = Set(testData.trackList.map { $0.name })
                            let actual = Set(result.value?.tracks?.compactMap { ($0 as? Track)?.title } ?? [])
                            
                            expect(actual).to(equal(expected))
                            
                            done()
                        }
                    }
                }
            }
            
            context("Fetching") {
                beforeEach {
                    sut = AlbumStorage.shared
                    
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.load { _ in
                            sut.clear()
                            sut.add(album: testData) { _ in done() }
                        }
                    }
                }
                
                it("should successfully fetch objects") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.fetchAlbums { result in
                            expect(result.isSuccess).to(beTrue())
                            done()
                        }
                    }
                }
                
                it("should fetch correct amount of objects") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.fetchAlbums { result in
                            expect(result.value?.count).to(equal(1))
                            done()
                        }
                    }
                }
                
                it("should fetch correct object") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.fetchAlbums { result in
                            let expected = testData.mbid
                            let actual = result.value?.first?.mbid
                            
                            expect(actual).to(equal(expected))
                            
                            done()
                        }
                    }
                }
            }
            
            context("Removing") {
                beforeEach {
                    sut = AlbumStorage.shared
                    
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.load { _ in
                            sut.clear()
                            sut.add(album: testData) { _ in done() }
                        }
                    }
                }
                
                it("should successfully remove object") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.remove(albumId: testData.mbid) { result in
                            expect(result.isSuccess).to(beTrue())
                            done()
                        }
                    }
                }
                
                it("should successfully remove object") {
                    waitUntil(timeout: Constants.timeout) { done in
                        sut.remove(albumId: testData.mbid) { _ in
                            sut.fetchAlbums { result in
                                expect(result.value).to(beEmpty())
                                done()
                            }
                        }
                    }
                }
            }
        }
    }
    
}

// MARK: Private

private extension AlbumStorageTests {
    
    static func makeAlbum() -> AlbumInfo.Album {
        let path = Bundle(for: AlbumStorageTests.self).path(forResource: "AlbumInfoTestsData", ofType: "json")!
        let url = URL(fileURLWithPath: path)
        
        return try! JSONDecoder().decode(AlbumInfo.self, from: Data(contentsOf: url)).album
    }
    
}
