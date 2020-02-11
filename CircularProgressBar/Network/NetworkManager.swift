//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import Foundation
let endPoint: URL = URL(string: "https://raw.githubusercontent.com/rentELtd/iostest/master/user.json")!

enum NetworkError: String, Error {
    case commonError = "Something went Wrong"
    case jsonError = "JSON Parsing Failed"

}

class NetworkManager: NetworkProtocol {
    //MARK: Fetching User Booking Info
       func fetchUsersBooking(completion: @escaping (Result <[Booking], NetworkError>) -> Void) {
           let task = URLSession.shared.dataTask(with: endPoint) {(data, response, error) in
               guard let responseStatus = response as? HTTPURLResponse, responseStatus.statusCode == 200 else {
                   completion(.failure(.commonError))
                   return
               }
               guard let data = data else { return }
               let users = try? JSONDecoder().decode(Users.self, from: data)
               if let booking = users?.bookings {
                   completion(.success(booking))
               } else {
                   completion(.failure(.jsonError))
               }
           }
           task.resume()
       }
}

