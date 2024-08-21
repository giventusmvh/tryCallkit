import CallKit
import AVFoundation

class CallKitProvider: NSObject, CXProviderDelegate {
    private let provider: CXProvider
    
    override init() {
        let providerConfiguration = CXProviderConfiguration(localizedName: "Your App Name")
        providerConfiguration.supportsVideo = false
        providerConfiguration.maximumCallsPerCallGroup = 1
        providerConfiguration.supportedHandleTypes = [.phoneNumber]
        
        provider = CXProvider(configuration: providerConfiguration)
        super.init()
        
        provider.setDelegate(self, queue: nil)
    }
    
    func provider(_ provider: CXProvider, perform action: CXStartCallAction) {
        configureAudioSession()
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        configureAudioSession()
        action.fulfill()
    }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
        deactivateAudioSession()
    }
    
    func providerDidReset(_ provider: CXProvider) {
        deactivateAudioSession()
    }
    
    private func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .voiceChat, options: .allowBluetooth)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    
    private func deactivateAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setActive(false, options: .notifyOthersOnDeactivation)
    }
}
