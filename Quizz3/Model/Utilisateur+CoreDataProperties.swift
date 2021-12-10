//
//  Utilisateur+CoreDataProperties.swift
//  Quizz3
//
//  Created by Mickael Pot on 18/11/2021.
//
//

import Foundation
import CoreData


extension Utilisateur {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Utilisateur> {
        return NSFetchRequest<Utilisateur>(entityName: "Utilisateur")
    }

    @NSManaged public var dateInscription: Date!
    @NSManaged public var login: String!
    @NSManaged public var password: String!

    
    

}

extension Utilisateur : Identifiable {

}
