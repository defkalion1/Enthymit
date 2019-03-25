//
//  Item.swift
//  Enthymit
//
//  Created by Defkalion on 24/02/2019.
//  Copyright © 2019 Constantine Defkalion. All rights reserved.
//

import Foundation
import RealmSwift

class HealthItem: Object {
    @objc dynamic var why = ""
    @objc dynamic var toMakeItHappen = ""
    @objc dynamic var expectations = ""
    @objc dynamic var stopped = ""
    @objc dynamic var difficulty : Float = 1.0
    var parentCategory = LinkingObjects(fromType: HealthData.self, property: "healthItems")
}

class SImprovementItem: Object {
    @objc dynamic var why = ""
    @objc dynamic var toMakeItHappen = ""
    @objc dynamic var expectations = ""
    @objc dynamic var stopped = ""
    @objc dynamic var difficulty : Float = 1.0
    var parentCategory = LinkingObjects(fromType: SelfImprovement.self, property: "selfImprovementItems")
}

class TopSecretItem: Object {
    @objc dynamic var why = ""
    @objc dynamic var toMakeItHappen = ""
    @objc dynamic var expectations = ""
    @objc dynamic var stopped = ""
    @objc dynamic var difficulty : Float = 1.0
    var parentCategory = LinkingObjects(fromType: TopSecret.self, property: "topSecretItems")
}

class OtherItem: Object {
    @objc dynamic var why = ""
    @objc dynamic var toMakeItHappen = ""
    @objc dynamic var expectations = ""
    @objc dynamic var stopped = ""
    @objc dynamic var difficulty : Float = 1.0
    var parentCategory = LinkingObjects(fromType: Other.self, property: "otherItems")
}
