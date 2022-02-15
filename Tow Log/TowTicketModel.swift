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
    var category: String?
    var pilot: String?
    var cfig: String?
    var glider: String?
    var tow_speed: String?
    var alt_required: String?
    var flight_brief: String?
    var remarks: String?
    
    
    //empty constructor
    
    override init() {
        
    }
    
    init(ticket_number: String, category: String, pilot: String, cfig: String, glider:String, tow_speed:String, alt_required:String, flight_brief:String, remarks:String) {

        
        self.ticket_number = ticket_number
        self.category = category
        self.pilot = pilot
        self.cfig = cfig
        self.glider = glider
        self.tow_speed = tow_speed
        self.alt_required = alt_required
        self.flight_brief = flight_brief
        self.remarks =  remarks
        
    }
    
    
    //prints object's current state
    
    override var description: String {
        return "ticket_number:\(String(describing: ticket_number)), category:\(String(describing: category)), pilot:\(String(describing: pilot)), cfig:\(String(describing: cfig)), glider:\(String(describing: glider)), tow_speed:\(String(describing: tow_speed)), alt_required:\(String(describing: alt_required)), flight_brief:\(String(describing: flight_brief)), remarks:\(String(describing: remarks))"

    }
    
    
}
