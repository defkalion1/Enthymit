//
//  Categories.swift
//  Enthymit
//
//  Created by Defkalion on 21/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import Foundation
import RealmSwift

class HealthData: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : Date?
    let healthItems = List<HealthItem>()
}

class SelfImprovement: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : Date?
    let selfImprovementItems = List<SImprovementItem>()
}

class TopSecret: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : Date?
    let topSecretItems = List<TopSecretItem>()
}

class Other: Object {
    @objc dynamic var name : String = ""
    @objc dynamic var dateCreated : Date?
    let otherItems = List<OtherItem>()
}

