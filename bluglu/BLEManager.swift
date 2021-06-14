//
//  BLEManager.swift
//  bleHR
//
//  Created by David Murphy on 6/10/21.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate {
    
    var myCentral: CBCentralManager!
    
    @Published var isSwitchedOn = false
    
    @Published var isScanning = false {
        didSet {
            if !isScanning {
                print("Scanning Stopped")
                myCentral.stopScan()
            }
            else if isScanning {
                print("Scanning Begins")
                myCentral.scanForPeripherals(withServices: nil, options: nil)
            }
        }
    }
    
    @Published var peripherals = [Peripheral]()
    
    override init() {
        super.init()
        
        myCentral = CBCentralManager(delegate: self, queue: nil)
        myCentral.delegate = self
    }
    
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isSwitchedOn = true
        }
        else {
            isSwitchedOn = false
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        var peripheralName: String!
        
        if let name = advertisementData[CBAdvertisementDataLocalNameKey] as? String {
            peripheralName = name
        }
        else {
            peripheralName = "[Unnamed]"
        }
        let newPeripheral = Peripheral(uuid: peripheral.identifier, name: peripheralName, rssi: RSSI.intValue)
        if !(peripherals.contains(newPeripheral)) {
            peripherals.append(newPeripheral)
            print("Found peripheral named: \(String(describing: peripheral.name))")
            for ad in advertisementData {
                print("AD Data: \(ad)")
            }
        }
    }
    
}
