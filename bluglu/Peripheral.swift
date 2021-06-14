//
//  Peripheral.swift
//  bluglu
//
//  Created by David Murphy on 6/13/21.
//

import Foundation

struct Peripheral: Identifiable, Equatable, Hashable {
    let id = UUID()
    let uuid: UUID
    let name: String
    let rssi: Int
    
    
    static func ==(lhs: Peripheral, rhs: Peripheral) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
