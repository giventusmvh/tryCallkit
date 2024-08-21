//
//  ContentView.swift
//  tryCallkit
//
//  Created by Giventus Marco Victorio Handojo on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Call App")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                makeCall()
            }) {
                Text("Call +6287780605052")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
    
    func makeCall() {
        let phoneNumber = "+6287780605052"
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            print("Attempting to call: \(phoneNumber)")
            if UIApplication.shared.canOpenURL(phoneURL) {
                UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
            } else {
                print("Cannot make a call. Check your device and settings.")
            }
        } else {
            print("Failed to create URL for the phone number.")
        }
    }
}
#Preview {
    ContentView()
}
