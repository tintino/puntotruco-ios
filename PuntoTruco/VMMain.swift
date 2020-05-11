//
//  ViewModelMain.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez Vega on 10/05/2020.
//  Copyright © 2020 T1incho. All rights reserved.
//

import Firebase

protocol VMMainProtocol: AnyObject {
    func subtractThem()
    func resetTapped()
    func subtractUs()
    func addThem()
    func addUs()
    func shared()
    func viewDidLoad()
    
    var themGamePoints: LiveData<Int> { get set }
    var usGamePoints: LiveData<Int> { get set }
    var gamePoints: LiveData<Int> { get set}
    var isGuestGame: LiveData<Bool> { get set}

}


class VMMain: VMMainProtocol {
    
    // MARK: - VMMainProtocol
    
    func subtractThem() {
        if let gameId = GameManager.shared.getGameId() {
            GameManager.shared.gamePointThem -= 1
            self.ref?.child("\(gameId)/them").setValue(GameManager.shared.gamePointThem)
        }
    }
    
    func resetTapped() {
        GameManager.shared.reset()
        if let gameId = GameManager.shared.getGameId() {
            self.ref?.child("\(gameId)/us").setValue(GameManager.shared.gamePointsUs)
            self.ref?.child("\(gameId)/them").setValue(GameManager.shared.gamePointThem)
        }
    }
    
    func subtractUs() {
        if let gameId = GameManager.shared.getGameId() {
            GameManager.shared.gamePointsUs -= 1
            self.ref?.child("\(gameId)/us").setValue(GameManager.shared.gamePointsUs)
        }
    }
    
    func addThem() {
        if let gameId = GameManager.shared.getGameId() {
            GameManager.shared.gamePointThem += 1
            self.ref?.child("\(gameId)/them").setValue(GameManager.shared.gamePointThem)
        }
    }
    
    func addUs() {
        if let gameId = GameManager.shared.getGameId() {
            GameManager.shared.gamePointsUs += 1
            self.ref?.child("\(gameId)/us").setValue(GameManager.shared.gamePointsUs)
        }
    }
    
    func shared() {
        print("TODO: implement shared")
    }
    
    func viewDidLoad() {
        ref = Database.database().reference()
        setupNewGame()
    }
    
    var themGamePoints: LiveData<Int>
    var usGamePoints: LiveData<Int>
    var isGuestGame: LiveData<Bool>
    var gamePoints: LiveData<Int>
    
    // MARK: - vars and cons
    
    var ref: DatabaseReference?
    var pointsLoadedFromCloud = false
    
    // MARK: - life cycle
    
    init() {
        themGamePoints = LiveData<Int>.init(value: GameManager.shared.gamePointThem)
        usGamePoints = LiveData<Int>.init(value: GameManager.shared.gamePointsUs)
        gamePoints = LiveData<Int>.init(value: GameManager.shared.gamePoints)
        isGuestGame = LiveData<Bool>.init(value: false)
        listenGuestPlayNotification()
    }
    
    // MARK: - private methods
    
    private func setupNewGame() {
        if let gameId = GameManager.shared.getGameId() {
            print("PuntoTruco: setupNewGame: \(gameId)")
            ref?.child(gameId).observe(DataEventType.value, with: { [unowned self] snapshot in
                if let postDict = snapshot.value as? [String : AnyObject]{
                    
                    
                    if let usPoints = postDict["us"] as? Int {

                        self.usGamePoints.value =  usPoints
                    }
                    if let themPoints = postDict["them"] as? Int {

                        self.themGamePoints.value = themPoints
                    }
                    
                    
//                    if !self.pointsLoadedFromCloud {
//                        GameManager.shared.gamePointsUs = usPoints
//                        GameManager.shared.gamePointThem = themPoints
//                        self.pointsLoadedFromCloud = true
//                    }
                    
                }
            })
        }
    }
    
    private func listenGuestPlayNotification() {
        NotificationCenter.default.addObserver(self,
                                                     selector: #selector(VMMain.onGuestGameNotification(_:)),
                                                     name: .guestPlay,
                                                     object: nil)
    }
    
    @objc private func onGuestGameNotification(_ notification: NSNotification) {
        print("PuntoTruco: onGuestGameNotification")

         guard let userInfo = notification.userInfo as? [String: String] else {
             return
         }
         
         if let guestGameId = userInfo["gameId"] {
            print("PuntoTruco: onGuestGameNotification: \(guestGameId)")
            self.isGuestGame.value = true
            GameManager.shared.isGuestPlay = true
            GameManager.shared.guestPlayId = guestGameId
            self.setupNewGame()
        }
    }
}
