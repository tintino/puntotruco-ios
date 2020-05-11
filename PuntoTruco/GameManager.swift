//
//  SettingsManager.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez Vega on 10/05/2020.
//  Copyright © 2020 T1incho. All rights reserved.
//

import UIKit

class GameManager {
    
    // MARK: - Singleton
    
    static let shared = GameManager()
    
    // MARK: - lifecycle
    
    private init() {
    }
    
    // MARK: - vars and cons
    
    var gamePoints = 18
    var gamePointsUs = 0
    var gamePointThem = 0
    var isGuestPlay = false
    var guestPlayId: String?
    let uniqueIdentifier = UIDevice.current.identifierForVendor?.uuidString

    // MARK: - public methods
    
    public func reset() {
        gamePointThem = 0
        gamePointsUs = 0
    }
    
    public func getGameId() -> String? {
        if isGuestPlay {
            return guestPlayId
        } else {
            return uniqueIdentifier
        }
    }
}
