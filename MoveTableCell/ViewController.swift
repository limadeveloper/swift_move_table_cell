//
//  ViewController.swift
//  MoveTableCell
//
//  Created by John Lima on 9/4/15.
//  Copyright © 2015 John Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK:
    // MARK: properties
    @IBOutlet var table: UITableView!
    
    var tableData: NSMutableArray = NSMutableArray()
    
    // MARK:
    // MARK: view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        table.delegate = self
        table.dataSource = self
        
        setview()
        getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:
    // MARK: actions
    func setview() {
        
        let background = UIView(frame: CGRectZero)
        table.tableFooterView = background
        table.backgroundColor = UIColor.whiteColor()
        
        createEditButton()
        
    }
    
    func getData() {
    
        for var i=0; i < 5; i++ {
            tableData.addObject("row \(i+1)")
        }
        
    }
    
    func createEditButton() {
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "edit")
        navigationItem.rightBarButtonItem = editButton
        
    }
    
    func createDoneButton() {
    
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "done")
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func edit() {
        createDoneButton()
        table.editing = true
    }
    
    func done() {
        createEditButton()
        table.editing = false
    }
    
    func createAlert(title: String?, message: String?, button: String?) {
        let alert = UIAlertController(title: title!, message: message!, preferredStyle: UIAlertControllerStyle.Alert)
        let action = UIAlertAction(title: button!, style: UIAlertActionStyle.Destructive, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    // MARK:
    // MARK: table view data source
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = tableData.objectAtIndex(indexPath.row) as? String
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, shouldIndentWhileEditingRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.None
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        let itemToMove = tableData[sourceIndexPath.row]
        tableData.removeObjectAtIndex(sourceIndexPath.row)
        tableData.insertObject(itemToMove, atIndex: destinationIndexPath.row)
        
        print("table data: \(tableData)")
        
    }
    
    // MARK:
    // MARK: table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        table.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = tableData.objectAtIndex(indexPath.row) as? String
        
        print("selected item: \(item!)")
        createAlert("Selected item", message: "\(item!)", button: "Ok")
        
    }

}

