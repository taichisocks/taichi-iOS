//
//  ViewController.swift
//  taichi-iOS
//
//  Created by taichi on 15/4/20.
//  Copyright (c) 2015 taichi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var socks5Label: UILabel!
    @IBOutlet weak var pacServerLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startProxy()
    }
    
    func startProxy()
    {
        let remoteHost = SettingsModel.sharedInstance.remoteHost
        if remoteHost.isEmpty {
            return;
        }
        var c_remote_host = remoteHost.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let remotePort = SettingsModel.sharedInstance.remotePort
        var c_remote_port = CInt(0)
        if let rPort = remotePort.toInt() {
            c_remote_port = CInt(rPort)
        }
        //        var c_remote_port = remotePort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let method = SettingsModel.sharedInstance.method
        var c_method = method.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let password = SettingsModel.sharedInstance.password
        var c_password = password.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let localHost = SettingsModel.sharedInstance.localHost
        var c_local_host = localHost.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        let localPort = SettingsModel.sharedInstance.localPort
        var c_local_port = CInt(0)
        if let lPort = localPort.toInt() {
            PacServer.sharedInstance.socks5Port = lPort
            c_local_port = CInt(lPort)
        }
        //        var c_local_port = localPort.cStringUsingEncoding(NSUTF8StringEncoding)!
        
        var lPacPort = 8100
        if let l = SettingsModel.sharedInstance.localPacPort.toInt() {
            lPacPort = l
        }
        
        startProxyWithConfig(c_remote_host, c_remote_port, c_method, c_password, c_local_host, c_local_port)
        
        PacServer.sharedInstance.start(listenPort: in_port_t(lPacPort), error: nil)

        socks5Label.text = "socks5: \(localHost):\(localPort)"
        pacServerLabel.text = "pac Server: http://localhost:\(lPacPort)/part.pac"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func fromSettingUnwind(segue: UIStoryboardSegue)
    {
        if let sourceController = segue.sourceViewController as? SettingTableViewController {
            var shouldAlert = true
            if SettingsModel.sharedInstance.remoteHost.isEmpty {
                shouldAlert = false
            }
            SettingsModel.sharedInstance.remoteHost = sourceController.remoteHostTextField.text
            SettingsModel.sharedInstance.remotePort = sourceController.remotPortTextField.text
            SettingsModel.sharedInstance.method = sourceController.methodTextField.text
            SettingsModel.sharedInstance.password = sourceController.passwordTextField.text
            SettingsModel.sharedInstance.localHost = sourceController.localHostTextField.text
            SettingsModel.sharedInstance.localPort = sourceController.localPortTextField.text
            SettingsModel.sharedInstance.localPacPort = sourceController.localPacPortTextField.text

            SettingsModel.sharedInstance.saveData()

            if shouldAlert {
                let alert = UIAlertView(title: "", message: "Please restart app", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            } else {
                startProxy()
            }
        }
    }

    @IBAction func fromSettingCancelUnnwind(segue: UIStoryboardSegue)
    {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

