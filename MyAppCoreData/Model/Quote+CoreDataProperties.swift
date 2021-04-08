//
//  Quote+CoreDataProperties.swift
//  MyAppCoreData
//
//  Created by Łukasz Rajczewski on 08/04/2021.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var body: String?
    @NSManaged public var title: String?
    @NSManaged public var state: Bool

}

extension Quote : Identifiable {

}
