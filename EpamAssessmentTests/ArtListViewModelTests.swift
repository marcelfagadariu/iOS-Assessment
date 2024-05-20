//
//  ArtListViewModelTests.swift
//
//  Created by Marcel on 19.05.2024.
//

import XCTest
@testable import EpamAssessment

final class ArtListViewModelTests: XCTestCase {

    var sut: ArtListViewModel!
    var mockService: MockArtService!

    override func setUp() {
        super.setUp()

        mockService = MockArtService()
        sut = ArtListViewModel(service: mockService)
    }

    override func tearDown() {
        sut = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Unit tests

    func testLoadDataSuccess() async throws {
        sut.loadData(with: .nl, pageSize: 10)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertTrue(mockService.hasBeenCalled)
        XCTAssertEqual(sut.art.count, ArtObject.mock.count)
        XCTAssertFalse(sut.isLoading)
        XCTAssertEqual(mockService.culture, "nl")
    }

    func testLoadDataFailure() async throws {
        let errorExpectation = expectation(description: "error should be true")
        mockService.shouldThrowError = true

        sut.onErrorOccurred = { isError in
            errorExpectation.fulfill()
        }

        sut.loadData(with: .en, pageSize: 10)
        try await Task.sleep(nanoseconds: 1_000_000_000)
        XCTAssertTrue(mockService.hasBeenCalled)
        XCTAssertFalse(sut.isLoading)
        await fulfillment(of: [errorExpectation], timeout: 1)
    }

    func testIsLoadingState() async throws {
        let loadingExpectation = expectation(description: "isLoading should be true")
        let loadedExpectation = expectation(description: "isLoading should be false")

        sut.onLoadingStateChanged = { isLoading in
            if isLoading {
                loadingExpectation.fulfill()
            } else {
                loadedExpectation.fulfill()
            }
        }

        sut.loadData(with: .nl, pageSize: 10)
        await fulfillment(of: [loadingExpectation, loadedExpectation], timeout: 1)
    }
}
