//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import Foundation

protocol NetworkProtocol {
    //Result is the collection of Users
    func fetchUsersBooking(completion: @escaping (Result <[Booking], NetworkError>) -> Void)

}
