//
//  DoubleFormatter.swift
//  Calculadora
//
//  Created by jorge on 30/7/21.
//

import Foundation

extension Double {
    
    var clean: String {
        // Instead of Double % 1 == 0, we use this method
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}

