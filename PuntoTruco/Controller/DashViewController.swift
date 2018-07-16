//
//  DashViewController.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez vega on 15/07/2018.
//  Copyright © 2018 T1incho. All rights reserved.
//

import UIKit

class DashViewController: UIViewController {
    
    // MARK - IBOutlets
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var labelThem: UILabel!
    @IBOutlet weak var labelUS: UILabel!
    @IBOutlet weak var gridUs: PTMatchstickGrid!
    @IBOutlet weak var gridThem: PTMatchstickGrid!
    
    // MARK - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGridUs()
        setupGridThem()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        
        /*
        gridUs.setTotal(withMaxValue: 15)
        gridThem.setTotal(withMaxValue: 15)
        separator.isHidden = true
         */
    }
    
    // MARK - private methods
    
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
    
    // MARK - IBActions
    
    @IBAction func usAddPoint(_ sender: Any) {
        gridUs.add()
    }
    
    @IBAction func usSubstractPoint(_ sender: Any) {
        gridUs.substract()
    }
    
    @IBAction func themAddPoint(_ sender: Any) {
        gridThem.add()
    }
    
    @IBAction func themSubstractPoint(_ sender: Any) {
        gridThem.substract()
    }
    
    @IBAction func resetPoints(_ sender: Any) {
        Alert.reset(onVC: self, onYes: {
            self.gridUs.reset()
            self.gridThem.reset()
        })        
    }
}
