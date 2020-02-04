//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import Foundation

// MARK: - Users
struct Users: Decodable {
    
    let bookings: [Booking]
    enum CodingKeys: String, CodingKey {
        case bookings
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        bookings = try container.decode(Array.self, forKey: .bookings)
    }
}

// MARK: - Booking
struct Booking: Decodable {
    let car: Car
    let subscriptionMilesLeft: String?
    
    enum CodingKeys: String, CodingKey {
        case car
        case subscriptionMilesLeft = "subscription_miles_left"
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        car = try container.decode(Car.self, forKey: .car)
        subscriptionMilesLeft =  try container.decode(String.self, forKey: .subscriptionMilesLeft)
    }
}

// MARK: - Car
struct Car: Decodable {
    let lastEnergyLevel: String?

    enum CodingKeys: String, CodingKey {
        case lastEnergyLevel = "last_energy_level"
    }
    init(from decoder: Decoder)throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lastEnergyLevel =  try container.decode(String.self, forKey: .lastEnergyLevel)
    }
}

