//
//  ReceivedData+CoreDataProperties.swift
//  
//
//  Created by Juan Carlos on 16/03/23.
//
//

import Foundation
import CoreData


extension ReceivedData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReceivedData> {
        return NSFetchRequest<ReceivedData>(entityName: "ReceivedData")
    }

    @NSManaged public var clave: String?
    @NSManaged public var respuesta: String?

}
