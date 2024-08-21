//
//  CallManager.swift
//  tryCallkit
//
//  Created by Giventus Marco Victorio Handojo on 21/08/24.
//

import CallKit
import Combine

class CallManager: NSObject, ObservableObject {
    private let callController = CXCallController()
    
    func startCall(handle: String) {
        let handle = CXHandle(type: .phoneNumber, value: handle)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        let transaction = CXTransaction(action: startCallAction)
        
        requestTransaction(transaction)
    }
    
    func endCall(call: UUID) {
        let endCallAction = CXEndCallAction(call: call)
        let transaction = CXTransaction(action: endCallAction)
        
        requestTransaction(transaction)
    }
    
    private func requestTransaction(_ transaction: CXTransaction) {
        callController.request(transaction) { error in
            if let error = error {
                print("Error requesting transaction: \(error.localizedDescription)")
            } else {
                print("Requested transaction successfully")
            }
        }
    }
}
