//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import Foundation

class ProgressViewModel {
    
    let networkManager: NetworkProtocol
    var showErrorMessage:(() -> Void)?
    var showProgressBar: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    init( networkService: NetworkProtocol = NetworkManager()) {
        self.networkManager = networkService
    }
    
    //Error alert Message
    var alertMessage: String = "Something went Wrong" {
        didSet {
            showErrorMessage?()
        }
    }
    //Customised User Data Booking View Model
    var bookingViewModel: BookingModel! {
        didSet {
            showProgressBar?()
        }
    }
        
    //To Show Animator
    var isLoading: Bool = false {
        didSet {
            updateLoadingStatus?()
        }
    }
    
    //MARK: Fetch User Data from Network
    func fetchUserData() {
        isLoading = true
        networkManager.fetchUsersBooking {[weak self] (result) in
            guard let self = self else {return}
            self.isLoading = false
            switch result {
            case .failure(let error):
                self.alertMessage = error.rawValue
            case .success(let bookings):
                self.processBookingData(booking: bookings)
            }
        }
    }
    //Process Model Data
    func processBookingData(booking: [Booking]) {
        self.bookingViewModel =  BookingModel(model: booking.first)
    }
}


