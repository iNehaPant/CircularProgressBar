

import Foundation
import XCTest
@testable import CircularProgressBar

class ProgressViewModelTests: XCTestCase {
    var sut: ProgressViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = ProgressViewModel(networkService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_User_Data() {
        // Given
        mockAPIService.completeBookings = [Booking]()
        
        // When
        sut.fetchUserData()
        
        // Assert
        XCTAssert(mockAPIService!.isFetchUserBookingsCalled)
    }
    
    func test_fetch_User_Date_fail() {
        
        // Given a failed fetch with a certain failure
        let error = NetworkError.commonError
        
        // When
        sut.fetchUserData()
        
        mockAPIService.fetchFail(error: error)
        
        // Sut should display predefined error message
        XCTAssertEqual(sut.alertMessage, error.rawValue)
        
    }
    
    func test_loading_when_fetching_Sucess() {
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.fetchUserData()
        
        // Assert
        XCTAssertTrue(loadingStatus)
        
        // When finished fetching
        mockAPIService!.fetchSuccess()
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func test_loading_when_fetching_Failure() {
        //Given
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading status updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        //when fetching
        sut.fetchUserData()
        
        // Assert
        XCTAssertTrue(loadingStatus)
        
        // When finished fetching
        mockAPIService!.fetchFail(error: .commonError)
        XCTAssertFalse(loadingStatus)
        
        wait(for: [expect], timeout: 1.0)
    }
    
    func test_booking_view_model() {
        guard let bookingsData = UserModelUtility().getStubBookingJSON() else {return}
        let data = UserModelUtility().getBookingViewModel(bookings: bookingsData)
        if let bookings: BookingViewModel = data?.first {
            XCTAssertEqual(bookings.subscriptionMilesLeft, 747)
            XCTAssertEqual(bookings.lastEnergyLevel, 72.0)
        }
    }
}

class MockApiService: NetworkProtocols {
    
    var isFetchUserBookingsCalled = false
    var completeBookings: [Booking] = [Booking]()
    var completeClosure: ((Result<[Booking], NetworkError>) -> ())!
    
    func fetchUsersBooking(completion: @escaping (Result<[Booking], NetworkError>) -> Void) {
        isFetchUserBookingsCalled = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure(.success(completeBookings))
    }
    
    func fetchFail(error: NetworkError?) {
        completeClosure(.failure(.commonError))
    }
    
}
