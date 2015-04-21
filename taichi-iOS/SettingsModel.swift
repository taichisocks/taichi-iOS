//
//  SettingsModel.swift
//  taichiOSX
//
//  Created by taichi on 15/4/20.
//  Copyright (c) 2015 taichi. All rights reserved.
//

import Foundation

class SettingsModel
{
    var remoteHost = ""
    var remotePort = ""
    var method = ""
    var password = ""
    var localHost = "127.0.0.1"
    var localPort = "1080"
    var localPacPort = "8100"
    
    class var sharedInstance: SettingsModel {
        struct Static {
            static var instance: SettingsModel? = nil
        }
        if Static.instance == nil {
            Static.instance = SettingsModel()
            Static.instance?.loadData()
        }
        return Static.instance!
    }
    
    private struct KeyNames {
        static let remoteHost = "taichi.remoteHost"
        static let remotePort = "taichi.remotePort"
        static let method = "taichi.method"
        static let password = "taichi.password"
        static let localHost = "taichi.localHost"
        static let localPort = "taichi.localPort"
        static let localPacPort = "taichi.localPacPort"
    }

    func loadData()
    {
        remoteHost = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.remoteHost) ?? ""
        remotePort = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.remotePort) ?? ""
        method     = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.method) ?? ""
        password   = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.password) ?? ""
        localHost  = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.localHost) ?? "127.0.0.1"
        localPort  = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.localPort) ?? "8121"
        localPacPort  = NSUserDefaults.standardUserDefaults().stringForKey(KeyNames.localPacPort) ?? "8100"
    }
    
    func saveData()
    {
        NSUserDefaults.standardUserDefaults().setObject(remoteHost, forKey: KeyNames.remoteHost)
        NSUserDefaults.standardUserDefaults().setObject(remotePort, forKey: KeyNames.remotePort)
        NSUserDefaults.standardUserDefaults().setObject(method, forKey: KeyNames.method)
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: KeyNames.password)
        NSUserDefaults.standardUserDefaults().setObject(localHost, forKey: KeyNames.localHost)
        NSUserDefaults.standardUserDefaults().setObject(localPort, forKey: KeyNames.localPort)
        NSUserDefaults.standardUserDefaults().setObject(localPacPort, forKey: KeyNames.localPacPort)
    }
}