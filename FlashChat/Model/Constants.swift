//
//  Constants.swift
//  FlashChat
//
//  Created by Alexandre Robaert on 03/08/20.
//  Copyright © 2020 Alexandre Robaert. All rights reserved.
//

import Foundation

struct K {
    static let appName = "⚡️FlashChat"
    static let meCellIdentifier = "MeCell"
    static let youCellIdentifier = "YouCell"
    static let meCellNibName = "MeTableViewCell"
    static let youCellNibName = "YouTableViewCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
