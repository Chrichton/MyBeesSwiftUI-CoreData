//
//  Location+CoreDataProperties.swift
//  MyBeesSwiftUI
//
//  Created by Heiko Goes on 05.09.19.
//  Copyright © 2019 Heiko Goes. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

extension Location {

    @NSManaged public var name: String
    @NSManaged public var street: String
    @NSManaged public var color: UIColor

    static func allLocationsFetchRequest() -> NSFetchRequest<Location> {
        let request: NSFetchRequest<Location> = Location.fetchRequest() as! NSFetchRequest<Location>
        
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        return request
    }

}
