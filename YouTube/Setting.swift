//
//  Setting.swift
//  YouTube
//
//  Created by Omry Dabush on 12/12/2016.
//  Copyright © 2016 Omry Dabush. All rights reserved.
//

import UIKit

class Setting: NSObject{
    let name: settingName
    let iconName : String
    
    init(name: settingName, iconName: String) {
        self.name = name
        self.iconName = iconName
    }
    
}

enum settingName: String {
    case cancel = "Cancel"
    case settings = "Settings"
    case termsPrivacy = "Terms & Privacy Policy"
    case sendFeedback = "Send Feedback"
    case help = "Help"
    case swichAccount = "Swich Account"
}
