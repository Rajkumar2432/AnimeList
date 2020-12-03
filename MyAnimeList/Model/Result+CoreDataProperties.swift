//
//  Result+CoreDataProperties.swift
//  MyAnimeList
//
//  Created by Rajkumar Gurunathan on 03/12/20.
//  Copyright © 2020 Rajkumar Gurunathan. All rights reserved.
//
//

import Foundation
import CoreData


extension Result {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
        return NSFetchRequest<Result>(entityName: "Result")
    }

    @NSManaged public var episodes: Int64
    @NSManaged public var image: Data?
    @NSManaged public var image_url: String?
    @NSManaged public var score: Float
    @NSManaged public var synopsis: String?
    @NSManaged public var title: String?
    @NSManaged public var type: String?

}
