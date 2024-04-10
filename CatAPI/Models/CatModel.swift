//
//  CatModel.swift
//  CatAPI
//

import Foundation


//  weight: {
//    imperial: "7  -  10",
//    metric: "3 - 5"
//  },

class Weight : Codable {
    var imperial : String
    var metric : String
}

//  image: {
//      id: "0XYvRd7oD",
//      width: 1204,
//      height: 1445,
//      url: "https://cdn2.thecatapi.com/images/0XYvRd7oD.jpg"
//  }
class CatImage : Codable, Identifiable {
    var id : String
    var width : Int
    var height : Int
    var url : String
}



//  id: "abys",
//  name: "Abyssinian",
//  temperament: "Active, Energetic, Independent, Intelligent, Gentle",
//  origin: "Egypt",
//  description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats an  and love both people and other animals.",
//  life_span: "14 - 15",
//  indoor: 0,
//  child_friendly: 3,
//  intelligence: 5,
//  wikipedia_url: "https://en.wikipedia.org/wiki/Abyssinian_(cat)",

class CatModel : Codable, Identifiable {
    var weight : Weight
    var id : String
    var name : String
    var temperament: String?
    var origin : String
    var description : String
    var lifeSpan : String
    var isIndoor : Bool
    var intelligence : Int?
    var childFriendly : Int?
    var wikipediaURL : String?
    var catImage : CatImage?
    
    init(
        weight: Weight,
        id: String,
        name: String,
        lifeSpan : String,
        catImage : CatImage,
        origin : String,
        description : String,
        wikipediaURL : String = "",
        temperament: String = "",
        intelligence : Int = 0,
        childFriendly : Int = 0,
        isIndoor : Bool
    ) {
        self.weight = weight
        self.id = id
        self.name = name
        self.lifeSpan = lifeSpan
        self.origin = origin
        self.description = description
        self.wikipediaURL = wikipediaURL
        self.isIndoor = isIndoor
        self.intelligence = intelligence
        self.childFriendly = childFriendly
        self.temperament = temperament
        self.catImage = catImage
    }
    
    
    enum CodingKeys: String, CodingKey {
        case weight
        case id
        case name
        case lifeSpan = "life_span"
        case origin
        case description
        case isIndoor = "indoor"
        case wikipediaURL = "wikipedia_url"
        case catImage = "image"
        case intelligence
        case temperament
        case childFriendly = "child_friendly"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.weight = try values.decode(Weight.self, forKey: .weight)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.lifeSpan = try values.decode(String.self, forKey: .lifeSpan)
        self.origin = try values.decode(String.self, forKey: .origin)
        self.description = try values.decode(String.self, forKey: .description)
        let indoor = try values.decode(Int.self, forKey: .isIndoor)
        self.isIndoor = indoor == 1 ? true : false
        let wikiURL = try? values.decode(String.self, forKey: .wikipediaURL)
        self.wikipediaURL = wikiURL == nil ? "" : wikiURL
        self.intelligence = try values.decode(Int.self, forKey: .intelligence)
        self.childFriendly = try values.decode(Int.self, forKey: .childFriendly)
        self.temperament = try values.decode(String.self, forKey: .temperament)
        self.catImage = try values.decodeIfPresent(CatImage.self, forKey: .catImage)
    }
}

