//
//  LiveData.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez Vega on 10/05/2020.
//  Copyright © 2020 T1incho. All rights reserved.
//

import Foundation

import Foundation

class LiveData<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
    
    public func bind(listener: Listener?) {
        self.listener = listener
        self.listener?(value)
    }
    
    public func notifyToListeners() {
        listener?(value)
    }
}
