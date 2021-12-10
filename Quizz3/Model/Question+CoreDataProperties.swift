//
//  Question+CoreDataProperties.swift
//  Quizz3
//
//  Created by Mickael Pot on 18/11/2021.
//
//

import Foundation
import CoreData


extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var idQuestion: Int32
    @NSManaged public var reponseA: String?
    @NSManaged public var reponseB: String?
    @NSManaged public var reponseC: String?
    @NSManaged public var reponseD: String?
    @NSManaged public var categorie: String?

}

extension Question : Identifiable {

}
