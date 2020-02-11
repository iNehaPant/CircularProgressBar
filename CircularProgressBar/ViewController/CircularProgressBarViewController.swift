//
//  CircularProgressBar
//
//  Created by Neha Pant on 04/02/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import UIKit

class CircularProgressBarViewController: UIViewController {
    
    @IBOutlet weak var outerEnergyView: CircularProgressBarView!
    @IBOutlet weak var outerMilesView: CircularProgressBarView!
    @IBOutlet weak var energyCircularProgress: CircularProgressBarView!
    @IBOutlet weak var milesCircularProgress: CircularProgressBarView!
    @IBOutlet weak var energyCircularLbl: UILabel!
    @IBOutlet weak var milesCircularLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    var vSpinner: UIView? // loading indicator
    
    lazy var viewModel: ProgressViewModel = {
        return ProgressViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProgressBarUI()
        initViewModel()
    }
    
    func initViewModel() {
        //show progressBar data
        initProgressBar()
        
        //show error messgae
        initErrorMessage()
        
        //Loading Animator
        initLoadingStatus()
        
        //Fetch network data
        viewModel.fetchUserData()
    }
    
    //MARK: Show Progress bar UI
    func initProgressBar() {
        viewModel.showProgressBar = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                //Miles Data
                let subscriptionMilesLeft = self.viewModel.bookingViewModel.subscriptionMilesLeft
                self.milesCircularProgress.setProgressWithAnimation(duration: 1.0, value: subscriptionMilesLeft/1000)
                self.milesCircularLbl.text = String(subscriptionMilesLeft)
                
                //Energy Level data
                let lastEnergyLevel = self.viewModel.bookingViewModel.lastEnergyLevel
                self.energyCircularProgress.setProgressWithAnimation(duration: 1.0, value: (lastEnergyLevel)/100)
                self.energyCircularLbl.text = String(lastEnergyLevel) + "%"
            }
            
        }
    }
    //MARK: Alert Message
    func initErrorMessage() {
        viewModel.showErrorMessage = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.containerView.isHidden = true
                let alert = UIAlertController(title: "Alert", message: self.viewModel.alertMessage, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    //MARK: AnimationStatus
    func initLoadingStatus() {
        viewModel.updateLoadingStatus = {[weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                if self.viewModel.isLoading {
                    self.containerView.isHidden = true
                    self.showSpinner()
                } else {
                    self.containerView.isHidden = false
                    self.removeSpinner()
                }
            }
        }
    }
    
    func setProgressBarUI() {
        containerView.isHidden = true
        outerEnergyView.trackColor = UIColor.lightGray
        outerMilesView.trackColor = UIColor.lightGray
    }
    
    //MARK: Refresh Icon Tap
    @IBAction func refereshAction(sender: UIButton) {
        viewModel.fetchUserData()
    }
}

extension CircularProgressBarViewController {
    //MARK: LOADING INDICATOR
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            self.view.addSubview(spinnerView)
            self.view.bringSubviewToFront(spinnerView)
        }
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

