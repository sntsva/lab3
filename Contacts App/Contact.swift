//
//  Contact.swift
//  Contacts App
//
//  Created by Alua Santassova on 06.04.2022.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var number: String = ""
    @objc dynamic var gender: String = ""
}
