//
//  URL+Extension.swift
//  PuntoTruco
//
//  Created by Martin Gonzalez Vega on 10/05/2020.
//  Copyright © 2020 T1incho. All rights reserved.
//

import Foundation

extension URL {
    func valueOf(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
