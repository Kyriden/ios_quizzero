//
//  Reponse+CoreDataProperties.swift
//  Quizz3
//
//  Created by Mickael Pot on 18/11/2021.
//
//

import Foundation
import CoreData


extension Reponse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reponse> {
        return NSFetchRequest<Reponse>(entityName: "Reponse")
    }

    @NSManaged public var idReponse: Int32
    @NSManaged public var reponseQuestion: String?

}

extension Reponse : Identifiable {

}
