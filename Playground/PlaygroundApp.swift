//
//  PlaygroundApp.swift
//  Playground
//
//  Created by Rasmus Krämer on 22.12.24.
//

import SwiftUI
import SwiftData

@main
struct PlaygroundApp: App {
    init() {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let sysname = String(decoding: withUnsafeBytes(of: systemInfo.sysname.self) { [UInt8]($0) }, as: UTF8.self)
        let nodename = String(decoding: withUnsafeBytes(of: systemInfo.nodename.self) { [UInt8]($0) }, as: UTF8.self)
        let release = String(decoding: withUnsafeBytes(of: systemInfo.release.self) { [UInt8]($0) }, as: UTF8.self)
        let version = String(decoding: withUnsafeBytes(of: systemInfo.version.self) { [UInt8]($0) }, as: UTF8.self)
        let machine = String(decoding: withUnsafeBytes(of: systemInfo.machine.self) { [UInt8]($0) }, as: UTF8.self)
        
        print(sysname, nodename, release, version, machine)
        
        print(withUnsafeBytes(of: 2024) { [UInt8]($0) }.reversed().reduce(0) { $0 << 8 | Int($1) })
        
        print([UInt8](repeating: 0x00, count: 7).count)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

extension Array {
    init(repeating: Element, count: Int) {
        self.init((0..<count).map { _ in repeating })
    }
}

#if os(iOS)
import UIKit

var motionStarted: Date?

extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            motionStarted = .now
        }
    }
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if let motionStarted, motion == .motionShake {
            print(motionStarted.distance(to: .now))
        }
     }
}
#endif
