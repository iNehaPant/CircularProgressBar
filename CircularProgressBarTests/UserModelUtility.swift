

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
    
    func getBookingViewModel(bookings : [Booking]) -> [BookingViewModel]! {
        var array = [BookingViewModel]()
        for booking in bookings {
            var subscriptionMiles = 0.0
                   var energyLevel = 0.0
            if let sub = booking.subscriptionMilesLeft {
                subscriptionMiles = Double(sub)!
            }
            if let eneLevel = booking.car.lastEnergyLevel {
                energyLevel = Double(eneLevel)!
            }
            array.append(BookingViewModel(subscriptionMilesLeft: subscriptionMiles, lastEnergyLevel: energyLevel))
        }
        return array
    }
}
