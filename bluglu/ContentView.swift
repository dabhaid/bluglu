import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
        NavigationView {
            VStack {
                BleDeviceList(BlePeripherals: bleManager.peripherals)
                Spacer()
                
                // Check and warn if bluetooth is off
                if bleManager.isSwitchedOn {
                    Toggle("Scan for devices", isOn: self.$bleManager.isScanning).padding()
                    
                }
                else  {
                    Text("Bluetooth is NOT switched on!")
                        .foregroundColor(.red)
                }
                
            }
            .navigationTitle("\(bleManager.peripherals.count) BLE Devices")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Device List Layout
struct BleDeviceList: View {
    var BlePeripherals = [Peripheral]()
    
    var body: some View {
        List(BlePeripherals) {
            peripheral in HStack() {
                BleDevice(name: peripheral.name, uuid: peripheral.uuid.uuidString, rssi: peripheral.rssi)
            }
        }
        .listStyle(PlainListStyle())
    }
}


#if DEBUG
struct BleDeviceListPreview: PreviewProvider {
    static var BLEDevices = [
        Peripheral(uuid: UUID(), name: "item one", rssi: -32),
        Peripheral(uuid: UUID(), name: "item two", rssi: -32),
        Peripheral(uuid: UUID(), name: "item three", rssi: -32)
    ]
    
    
    static var previews: some View {
        NavigationView {
            VStack {
                BleDeviceList(BlePeripherals: BLEDevices)
            }.navigationTitle("\(BLEDevices.count) BLE Devices")
        }
    }
}
#endif

// List Item layout
struct BleDevice: View {
    var name: String
    var uuid: String
    var rssi: Int
    
    var body: some View {
        HStack(){
            VStack(alignment: .leading) {
                Text(name)
                Text(uuid)
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            Spacer()
            Text("(\(String(rssi)))")
                .font(.caption)
        }
        //        .background(Color.red)
        
    }
}

#if DEBUG
struct BLEDeviceRowPreview: PreviewProvider {
    static var previews: some View {
        BleDevice(name: "test", uuid: "2562", rssi: -32)
    }
}
#endif
