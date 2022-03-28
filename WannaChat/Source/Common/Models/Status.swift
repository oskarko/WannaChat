//
//  Status.swift
//  WannaChat
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2022 Oscar R. Garrucho. All rights reserved.
//

import Foundation

enum Status: Int, CaseIterable {
    case available
    case busy
    case atSchool
    case AtTheMovies
    case atWork
    case batteryAboutToDie
    case cantTalk
    case inAMeeting
    case atTheGym
    case sleeping
    case urgentCallsOnly
    case app
}

extension Status {
    public var stringValue: String {
        switch self {
        case .available: return "Available"
        case .busy: return "Busy"
        case .atSchool: return "At School"
        case .AtTheMovies: return "At The Movies"
        case .atWork: return "At Work"
        case .batteryAboutToDie: return "Battery about to die"
        case .cantTalk: return "Can't talk"
        case .inAMeeting: return "In a Meeting"
        case .atTheGym: return "At the Gym"
        case .sleeping: return "Sleeping"
        case .urgentCallsOnly: return "Urgent calls only"
        case .app: return "Hey there! I'm using WannaChat"
        }
    }
}
