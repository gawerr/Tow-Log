//
//  HomeModel.swift
//  Tow Log
//
//  Created by Randy Gawer on 2/13/22.
//

import Foundation

// loction model

class TowTicketModel: NSObject {
    
    //properties
    var ticket_number: String?
    var glider: String?
    var category: String?
    var flight_brief: String?
    var pilot: String?
    var cfig: String?
    var guest: String?
    var tow_speed: String?
    var alt_required: String?
    var remarks: String?
    
    //empty constructor
    override init() {
        
    }
    
    init(ticket_number: String, glider:String, category: String, flight_brief:String, pilot: String, cfig: String,  guest:String, tow_speed:String, alt_required:String,  remarks:String) {

        self.ticket_number = ticket_number
        self.glider = glider
        self.category = category
        self.flight_brief = flight_brief
        self.pilot = pilot
        self.cfig = cfig
        self.guest = guest
        self.tow_speed = tow_speed
        self.alt_required = alt_required
        self.remarks =  remarks
        
    }
    
    
    //prints object's current state
    override var description: String {
        return "ticket_number:\(String(describing: ticket_number)), glider:\(String(describing: glider)), category:\(String(describing: category)), flight_brief:\(String(describing: flight_brief)), pilot:\(String(describing:pilot)), cfig:\(String(describing:cfig)), guest:\(String(describing:guest)), tow_speed:\(String(describing: tow_speed)), alt_required:\(String(describing: alt_required)), remarks:\(String(describing: remarks))"
    }
    
}
