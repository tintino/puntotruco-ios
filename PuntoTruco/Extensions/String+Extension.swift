//
//  String+Extension.swift
//  Guia Mendoza Gourmet
//
//  Created by Martin Gonzalez vega on 16/7/17.
//  Copyright © 2017 Martin Gonzalez vega. All rights reserved.
//
import UIKit

extension String {
    func translate() -> String{
        return NSLocalizedString(self, comment: "")
    }
}
