//
//  ViewController.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/11/22.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TowTicketPHPConnectorProtocol  {

    //Properties
    var feedItems: NSMutableArray = NSMutableArray()
    var selectedLocation : TowTicketModel = TowTicketModel()
    @IBOutlet weak var listTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set delegates and initialize TowTicketModel
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        let TowTicketPHPConnector = TowTicketPHPConnector()
        TowTicketPHPConnector.delegate = self
        TowTicketPHPConnector.downloadItems()
    }
    
    @IBAction func RefreshTickets(_ sender: Any) {
        print ("Send refresh")
        self.viewDidLoad()
        self.listTableView.reloadData()
    }
    
    func itemsDownloaded(items: NSMutableArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of feed items
        print("Items count", feedItems.count)
        return feedItems.count
           
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
       // Get the location to be shown
        let opentickets: TowTicketModel = feedItems[indexPath.row] as! TowTicketModel
        
//        print ("Index path row", feedItems[indexPath.row])
       
        let cell = self.listTableView.dequeueReusableCell(withIdentifier: "TicketCell", for: indexPath) as! TicketViewCell
        
        cell.TicketNumberLable.text = opentickets.ticket_number
        cell.GliderLable.text = opentickets.glider
        cell.CategoryLable.text = opentickets.category
        cell.FlightBriefLable.text = opentickets.flight_brief
        cell.PilotLable.text = opentickets.pilot
        cell.CFIGLable.text = opentickets.cfig
        cell.GuestLable.text = opentickets.guest
        cell.TowSpeedLable.text = opentickets.tow_speed
        cell.AltRequiredLable.text = opentickets.alt_required
        cell.RemarksLable.text = opentickets.remarks
       
        return cell
           
    }
    
    // the button action function
    @IBAction func uploadData(_ sender: Any) {
       
        let url = NSURL(string: "http://192.168.1.212/recieve-altrelease.php")
            
        var request = URLRequest(url: url! as URL)
        request.httpMethod = "POST"
        
        // starting POST string with a secretWord
        var dataString = "secretWord=44fdcv8jf3"
            
        // the POST string has entries separated by & add items as name and value
        
        // Test VARs
        let ticket_number = "52"
        let tow_plane = "N6782Z"
        let tow_pilot_member_id = "1059"
        let tow_pilot = "Randy Gawer"
        let alt_release = "8500"
        
        dataString = dataString + "&ticket_number=\(ticket_number)"
        dataString = dataString + "&tow_plane=\(tow_plane)"
        dataString = dataString + "&tow_pilot_member_id=\(tow_pilot_member_id)"
        dataString = dataString + "&tow_pilot=\(tow_pilot)"
        dataString = dataString + "&alt_release=\(alt_release)"
            
        // convert the post string to utf8 format
        let dataD = dataString.data(using: .utf8) // convert to utf8 string
            
        do {
            
        // the upload task, uploadJob, is defined here
        let uploadJob = URLSession.shared.uploadTask(with: request, from: dataD) {
        data, response, error in
        
        if error != nil {
                        
        // display an alert if there is an error inside the DispatchQueue.main.async
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Upload Didn't Work?", message: "Looks like the connection to the server didn't work.  Do you have Internet access?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
            } else {
                    if let unwrappedData = data {
                        
                        // Response from web server hosting the database
                        let returnedData = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                        if returnedData == "1" { // insert into database worked
                            

                            // display an alert if no error and database insert worked (return = 1) inside the DispatchQueue.main.async

                                DispatchQueue.main.async {
                                    let alert = UIAlertController(title: "Upload OK?", message: "Looks like the upload and insert into the database worked.", preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                        } else {
                            // display an alert if an error and database insert didn't worked (return != 1) inside the DispatchQueue.main.async

                                DispatchQueue.main.async {

                                let alert = UIAlertController(title: "Upload Didn't Work", message: "Looks like the insert into the database did not worked.", preferredStyle: .alert)
                                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                                self.present(alert, animated: true, completion: nil)
                                }
                            }
                        }
                    }
                }
                uploadJob.resume()
            }
        }


}
