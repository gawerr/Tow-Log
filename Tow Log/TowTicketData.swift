//
//  TowTicketData.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/13/22.
//

import Foundation

// home model

protocol TowTicketDataProtocol: AnyObject {
    func itemsDownloaded(items: NSArray)
}


class TowTicketData: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: TowTicketDataProtocol!
    
    var data = Data()
    
    // path to to towtickets service
    let urlPath: String = "http://devpi.local/service-towtickets.php"
    
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
           let locations = NSMutableArray()
           
           for i in 0 ..< jsonResult.count {
               
               jsonElement = jsonResult[i] as! NSDictionary
               
               let towticket = TowTicketModel()
               
               //the following insures none of the JsonElement values are nil through optional binding
               if   let ticket = jsonElement["ticket_nember"] as? String,
                    let category = jsonElement["category"] as? String,
                    let pilot = jsonElement["pilot"] as? String,
                    let cfig = jsonElement["cfig"] as? String,
                    let glider = jsonElement["glider"] as? String,
                    let tow_speed = jsonElement["tow_speed"] as? String,
                    let alt_required = jsonElement["alt_required"] as? String
                    
               {
                   
                   towticket.ticket_number = ticket
                   towticket.category = category
                   towticket.pilot = pilot
                   towticket.cfig = cfig
                   towticket.glider = glider
                   towticket.tow_speed = tow_speed
                   towticket.alt_required = alt_required
                   
               }
               
               locations.add(towticket)
               
           }
           
           DispatchQueue.main.async(execute: { () -> Void in
               
               self.delegate.itemsDownloaded(items: locations)
               
           })
       }

}
