//
//  DataReceived+CoreDataProperties.swift
//  
//
//  Created by Juan Carlos on 16/03/23.
//
//

import Foundation
import CoreData


extension DataReceived {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DataReceived> {
        return NSFetchRequest<DataReceived>(entityName: "DataReceived")
    }

    @NSManaged public var respuesta: String?
    @NSManaged public var clave: String?

}
