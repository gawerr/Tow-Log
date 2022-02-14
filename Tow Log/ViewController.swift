//
//  ViewController.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/11/22.
//

import UIKit

// location model is TowTicketModel


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TowTicketDataProtocol  {

    //Properties
    var feedItems: NSArray = NSArray()
    var selectedLocation : TowTicketModel = TowTicketModel()
    @IBOutlet weak var listTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set delegates and initialize homeModel
        
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let TowTicketData = TowTicketData()
        TowTicketData.delegate = self
        TowTicketData.downloadItems()
    }

    func itemsDownloaded(items: NSArray) {
           
           feedItems = items
           self.listTableView.reloadData()
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // Return the number of feed items
           return feedItems.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           // Retrieve cell
           let cellIdentifier: String = "BasicCell"
           let myCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)!
           // Get the location to be shown
           let item: TowTicketModel = feedItems[indexPath.row] as! TowTicketModel
           // Get references to labels of cell
           myCell.textLabel!.text = item.ticket_number
           
           return myCell
       }
    
    
}

