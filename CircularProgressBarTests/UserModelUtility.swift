

import UIKit
@testable import CircularProgressBar

class UserModelUtility {
    
    func getStubBookingJSON() -> [Booking]? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "BookingData", ofType: "json") else {
            fatalError("BookingData.json not found")
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let booking = try JSONDecoder().decode(Users.self, from: data)
            return booking.bookings
            
        } catch {
            //handle error
            print(error)
        }
        return nil
    }
    
    func getBookingViewModel(bookings : [Booking]) -> [BookingModel]! {
        var array = [BookingModel]()
        for booking in bookings {
             array.append(BookingModel(model: booking))
        }
        return array
    }
}
