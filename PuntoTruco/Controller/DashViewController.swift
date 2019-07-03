//
//  DashViewController.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez vega on 15/07/2018.
//  Copyright © 2018 T1incho. All rights reserved.
//

import UIKit
import Firebase

class DashViewController: UIViewController {
    
    // MARK - IBOutlets
    
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var labelThem: UILabel!
    @IBOutlet weak var labelUS: UILabel!
    @IBOutlet weak var gridUs: PTMatchstickGrid!
    @IBOutlet weak var gridThem: PTMatchstickGrid!
    
    
    
    var ref: DatabaseReference!
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
        
        ref = Database.database().reference()
        
        
        ref.child("JugadaId").observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            // ...
            self.gridUs.setPoints(value: postDict["us"] as! Int)
            
            self.gridThem.setPoints(value: postDict["them"] as! Int)
            
        })
        
    }
    
    // MARK - private methods
    
    func addUSPoint() {
        
        //self.ref.child("JugadaId").setValue(["us": gridUs.points])
        
        self.ref.child("JugadaId/us").setValue(gridUs.points)

    }
    
    func addThemPoint() {
        
        
        self.ref.child("JugadaId/them").setValue(gridThem.points)
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
    
    // MARK - IBActions
    
    @IBAction func usAddPoint(_ sender: Any) {
        gridUs.add()
        addUSPoint()
    }
    
    @IBAction func usSubstractPoint(_ sender: Any) {
        gridUs.substract()
        addUSPoint()
    }
    
    @IBAction func themAddPoint(_ sender: Any) {
        gridThem.add()
        addThemPoint()
    }
    
    @IBAction func themSubstractPoint(_ sender: Any) {
        gridThem.substract()
        
        addThemPoint()
    }
    
    @IBAction func resetPoints(_ sender: Any) {
        Alert.reset(onVC: self, onYes: {
            self.gridUs.reset()
            self.gridThem.reset()
        })        
    }
}
