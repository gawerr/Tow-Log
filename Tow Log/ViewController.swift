//
//  ViewController.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/11/22.
//

import UIKit

// location model is TowTicketModel

class TicketViewCell: UITableViewCell {
    
    @IBOutlet weak var TicketNumberLable: UILabel!
    @IBOutlet weak var CategoryLable: UILabel!
    
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TowTicketPHPConnectorProtocol  {

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
        
        let TowTicketPHPConnector = TowTicketPHPConnector()
        TowTicketPHPConnector.delegate = self
        TowTicketPHPConnector.downloadItems()
    }

    func itemsDownloaded(items: NSArray) {
           
           feedItems = items
           self.listTableView.reloadData()
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // Return the number of feed items
           print("Items count", feedItems.count)
           return feedItems.count
           
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
           // Get the location to be shown
           let opentickets: TowTicketModel = feedItems[indexPath.row] as! TowTicketModel
           
           let cell = self.listTableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketViewCell

           
           cell.TicketNumberLable.text = opentickets.ticket_number
           cell.CategoryLable.text = opentickets.category
        
           
           
           return cell
           
       }
    
    
}

