

import Foundation
import XCTest
@testable import CircularProgressBar

class UserModelTests: XCTest {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()

    }
    
    func testBookings() {
        if let bookingsData = UserModelUtility().getStubBookingJSON() {
            if let bookings = bookingsData.first {
                XCTAssertEqual(bookings.subscriptionMilesLeft, "742.0")
                XCTAssertEqual(bookings.car.lastEnergyLevel, "72.0")
            }
        }
    }
}
