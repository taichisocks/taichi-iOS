//
//  SettingTableViewController.swift
//  taichi-iOS
//
//  Created by taichi on 15/4/21.
//  Copyright (c) 2015 taichi. All rights reserved.
//

import UIKit

class SettingTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var remoteHostTextField: UITextField!
    @IBOutlet weak var remotPortTextField: UITextField!

    @IBOutlet weak var methodTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var localHostTextField: UITextField!
    @IBOutlet weak var localPortTextField: UITextField!
    
    @IBOutlet weak var localPacPortTextField: UITextField!
    
    @IBAction func methodDidBeginSelect(sender: UITextField)
    {
        sender.inputView = picker
    }

    var picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        remoteHostTextField.text = SettingsModel.sharedInstance.remoteHost
        remotPortTextField.text = SettingsModel.sharedInstance.remotePort
        methodTextField.text = SettingsModel.sharedInstance.method
        passwordTextField.text = SettingsModel.sharedInstance.password
        
        localHostTextField.text = SettingsModel.sharedInstance.localHost
        localPortTextField.text = SettingsModel.sharedInstance.localPort
        localPacPortTextField.text = SettingsModel.sharedInstance.localPacPort

        picker.dataSource = self
        picker.delegate = self
}
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return method.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String!
    {
        return method[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        methodTextField.text = method[row]
    }

    var method = [
        "table",
        "rc4",
        "rc4-md5",
        "aes-128-cfb",
        "aes-192-cfb",
        "aes-256-cfb",
        "bf-cfb",
        "camellia-128-cfb",
        "camellia-192-cfb",
        "camellia-256-cfb",
        "cast5-cfb",
        "des-cfb",
        "idea-cfb",
        "rc2-cfb",
        "seed-cfb",
        "salsa20",
        "chacha20"
    ]


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        if section == 0 {
            return 4
        } else {
            return 3
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
