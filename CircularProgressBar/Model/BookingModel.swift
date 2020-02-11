
//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import Foundation

struct BookingModel {
    var subscriptionMilesLeft: Double = 0.0
    var lastEnergyLevel: Double = 0.0
    
    init(model: Booking?) {
        if let booking = model {
            if let sub =  booking.subscriptionMilesLeft{
                self.subscriptionMilesLeft = Double(sub)!
            }
            if let milesLeft = booking.car.lastEnergyLevel{
                self.lastEnergyLevel = Double(milesLeft)!
            }
     }
   }
}
