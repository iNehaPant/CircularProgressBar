

import Foundation
import XCTest
@testable import CircularProgressBar


class NetworkManagerTest: XCTestCase {
    
    var networkManager: NetworkManager?
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        networkManager = NetworkManager()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_fetch_Bookings() {
        // Given A apiservice
        let nw = self.networkManager!
        
        // When fetch User data
        let expect = XCTestExpectation(description: "callback")
        nw.fetchUsersBooking(completion: { (result) in
            expect.fulfill()
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, NetworkError.commonError)
            case .success(let bookings):
                XCTAssertEqual(bookings.count, 1)
            }
        })
        wait(for: [expect], timeout: 10.0)
    }
}
