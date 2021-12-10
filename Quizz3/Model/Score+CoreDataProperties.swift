//
//  Score+CoreDataProperties.swift
//  Quizz3
//
//  Created by Mickael Pot on 18/11/2021.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var dateScore: Date?
    @NSManaged public var idScore: Int32
    @NSManaged public var scoreUtilisateur: Float
    @NSManaged public var userMonScore: String?

}

extension Score : Identifiable {

}
