//
//  SwitchStatus.swift
//  Eluxon
//
//  Created by Melanie Ren on 10/20/17.
//  Copyright © 2017 Melanie Ren. All rights reserved.
//

import Foundation

enum SwitchStatus: Togglable {
    case on, off
    
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}
