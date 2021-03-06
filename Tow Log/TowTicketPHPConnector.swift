//
//  TowTicketPHPConnector.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/13/22.
//

import Foundation

protocol TowTicketPHPConnectorProtocol: AnyObject {
    func itemsDownloaded(items: NSMutableArray)
}


class TowTicketPHPConnector: NSObject, URLSessionDataDelegate {
    
    weak var delegate: TowTicketPHPConnectorProtocol!
    var data = Data()
    
    // path to to towtickets service
    let urlPath: String = "http://devpi.local/service-towtickets.php"
//    let urlPath: String = "http://192.168.1.212/service-towtickets.php"
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
              self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
           
           var jsonResult = NSArray()
           
           do {
               jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
               
           } catch let error as NSError {
               print(error)
               
           }
           
           var jsonElement = NSDictionary()
           let tickets = NSMutableArray()
           
           for i in 0 ..< jsonResult.count {
               
               jsonElement = jsonResult[i] as! NSDictionary
               
               let towticket = TowTicketModel()
               
               //the following insures none of the JsonElement values are nil through optional binding
               if   let ticket = jsonElement["ticket_number"] as? String,
                    let glider = jsonElement["glider"] as? String,
                    let category = jsonElement["category"] as? String,
                    let flight_brief = jsonElement["flight_brief"] as? String,
                    let pilot = jsonElement["pilot"] as? String,
                    let cfig = jsonElement["cfig"] as? String,
                    let guest = jsonElement["guest"] as? String,
                    let tow_speed = jsonElement["tow_speed"] as? String,
                    let alt_required = jsonElement["alt_required"] as? String,
                    let remarks = jsonElement["remarks"] as? String
                    
               {
                  
                   towticket.ticket_number = ticket
                   towticket.category = category
                   towticket.flight_brief = flight_brief
                   towticket.pilot = pilot
                   towticket.cfig = cfig
                   towticket.guest = guest
                   towticket.glider = glider
                   towticket.tow_speed = tow_speed
                   towticket.alt_required = alt_required
                   towticket.remarks = remarks
                   
               }
               
               tickets.add(towticket)
               print("Connector Tickets:", towticket)
    
           }
           
           DispatchQueue.main.async(execute: { () -> Void in
               
               self.delegate.itemsDownloaded(items: tickets)
               
           })
       }

}
