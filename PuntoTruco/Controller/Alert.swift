//
//  Alert.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez vega on 16/07/2018.
//  Copyright © 2018 T1incho. All rights reserved.
//

import UIKit

struct Alert {
    private static func showBasicAlert(onVC vc: UIViewController, withTitle title: String, message msg: String, andOk ok:String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    public static func gameOver(onVC vc: UIViewController, winner team: String) {
        showBasicAlert(onVC: vc,
                       withTitle: "gameOver".translate(),
                       message: "\(team) \("isTheWinner".translate())",
            andOk: "okButton".translate())
    }
    
    public static func reset(onVC vc: UIViewController, onYes: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "resetPoints".translate(), message: "areYouSure".translate(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "yes".translate(), style: .destructive, handler: { action in
          onYes()
        }))
        alert.addAction(UIAlertAction(title: "no".translate(), style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }    
}
