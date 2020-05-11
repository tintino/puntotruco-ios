//
//  DashViewController.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez vega on 15/07/2018.
//  Copyright © 2018 T1incho. All rights reserved.
//

import UIKit
import Firebase

class VCMain: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var gridThem: PTMatchstickGrid!
    @IBOutlet weak var gridUs: PTMatchstickGrid!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var labelThem: UILabel!
    @IBOutlet weak var labelUS: UILabel!
    @IBOutlet weak var buttonSubtractThem: UIButton!
    @IBOutlet weak var buttonSubtractUs: UIButton!
    @IBOutlet weak var buttonAddThem: UIButton!
    @IBOutlet weak var buttonAddUs: UIButton!
    @IBOutlet weak var buttonReset: UIButton!
    @IBOutlet weak var labelGuestPlay: UILabel!
    
    
    // MARK: - var and cons
    
    private let viewModel = VMMain()
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGridUs()
        setupGridThem()
        setupNavigationBar()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        
        separator.isHidden = false
        bindViewModel()
        setupButtons()
        setupLabelGuest()
        viewModel.viewDidLoad()
    }
    
    // MARK: - private methods
    
    private func bindViewModel() {
        bindTotalPoints()
        bindPlayerPoints()
        bindIsGuestPlay()
    }
    
    private func bindTotalPoints() {
        viewModel.gamePoints.bind { [unowned self]  points in
            self.gridUs.setTotal(withMaxValue: points)
            self.gridThem.setTotal(withMaxValue: points)
        }
    }
    
    private func bindPlayerPoints() {
        viewModel.themGamePoints.bind { [unowned self] points in
            self.gridThem.setPoints(value: points)
        }
        viewModel.usGamePoints.bind { [unowned self] points in
            self.gridUs.setPoints(value: points)
        }
    }
    
    private func bindIsGuestPlay() {
        viewModel.isGuestGame.bind { [unowned self] isGuestGame in
            self.labelGuestPlay.isHidden = !isGuestGame            
        }
    }
    
    private func setupLabelGuest() {
        labelGuestPlay.text = "Guest Play"
        labelGuestPlay.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        labelGuestPlay.isUserInteractionEnabled = true
    }
    
    private func setupButtons() {
        buttonAddUs.tintColor = UIColor.white
        buttonAddThem.tintColor = UIColor.white
        buttonSubtractUs.tintColor = UIColor.white
        buttonAddThem.tintColor = UIColor.white
    }
    
    private func setupNavigationBar() {
        let settingsButton = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(settingsTapped))
        settingsButton.tintColor = UIColor.white
        let sharedItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        sharedItem.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [settingsButton, sharedItem]
        title = "PuntoTruco"
    }
    
    private func setupGridUs() {
        gridUs.onMaxPointsReached = {
            Alert.gameOver(onVC: self, winner: "us".translate())
        }
    }
    
    private func setupGridThem() {
        gridThem.onMaxPointsReached = {
            Alert.gameOver(onVC: self, winner: "them".translate())
        }        
    }
    
    // MARK: - IBActions
    
    @objc func settingsTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSettings", sender: nil)
    }
    
    @objc func shareTapped(_ sender: Any) {
        //viewModel.shared()
        guard let url = URL(string: "puntotruco://?gameId=\(GameManager.shared.getGameId() ?? "")") else {
            print("FAIL SHARED")
            return
        }
        
        
        let objectsToShare = [url]
        
        let activityVC = UIActivityViewController(activityItems:objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
        self.navigationController?.present(activityVC, animated: true, completion: nil)
        
    }
    
    @IBAction func usAddPoint(_ sender: Any) {
        viewModel.addUs()
    }
    
    @IBAction func usSubstractPoint(_ sender: Any) {
        viewModel.subtractUs()
    }
    
    @IBAction func themAddPoint(_ sender: Any) {
        viewModel.addThem()
    }
    
    @IBAction func themSubstractPoint(_ sender: Any) {
        viewModel.subtractThem()
    }
    
    @IBAction func resetPoints(_ sender: Any) {
        Alert.reset(onVC: self, onYes: {
            self.viewModel.resetTapped()
            self.gridUs.reset()
            self.gridThem.reset()
        })        
    }
}
