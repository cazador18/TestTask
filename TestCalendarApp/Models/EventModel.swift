//
//  EventModel.swift
//  TestCalendarApp
//
//  Created by Erzhan Kasymov on 26/8/23.
//

import UIKit

enum EventCalendarType {
    
    case calendar
    case event(model: [EventModel])
}

struct EventModel {
    
    let title: String?
    let time: String?
    let date: String?
}
