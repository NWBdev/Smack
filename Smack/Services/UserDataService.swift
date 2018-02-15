//
//  UserDataService.swift
//  Smack
//
//  Created by Nathaniel Burciaga on 2/14/18.
//  Copyright © 2018 Nathaniel Burciaga. All rights reserved.
//

import Foundation


class UserDataService {
    
    static let instance = UserDataService()
    
    // private(set) doesnt let other files change the data
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""

    
    //seter's UserDataService
    func setUserDataService(id: String, color:  String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    
    
    
}
