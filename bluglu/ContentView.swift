import SwiftUI

struct ContentView: View {
    
    @ObservedObject var bleManager = BLEManager()
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Discovered Devices")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .center)
            
            List(bleManager.peripherals) {
                peripheral in HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading) {
                        Text(peripheral.name)
                        Text(peripheral.uuid.uuidString).font(.subheadline)
                    }
                    Spacer()
                    Text("(\(String(peripheral.rssi)))")
                }
            }.padding()
            
            // Warn if bluetooth is off
            if !bleManager.isSwitchedOn {
                Text("Bluetooth is NOT switched on!")
                    .foregroundColor(.red)
            }
            
            Spacer()
            
            //
            if (self.bleManager.isScanning ) {
                Button(action: {
                    self.bleManager.stopScanning()
                }) {
                    Text("Stop Scanning")
                }
            } else {
                Button(action: {
                    self.bleManager.startScanning()
                }) {
                    Text("Start Scanning")
                }
            }
            
            Spacer()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
