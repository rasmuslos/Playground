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
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
