//
//  FilmModel.swift
//  Films
//
//  Created by Sefa DİNÇER on 23.08.2022.
//

import Foundation
import UIKit

struct FilmModel : Hashable{
    var title : String
    var description : String
    var year : String
    var imageUrl : String

}

extension FilmModel{
    init(json: [String: Any]) throws{
        
        guard let title = json["Title"] as? String
        else {
            print(  "title")
            throw SerializationError.missing("title")
        }
        
        guard let description = json["Plot"] as? String
        else{
            print("desc")
            throw SerializationError.missing("description")
        }
        
        guard let year = json["Year"] as? String
        else{
            
            throw SerializationError.missing("year")
        }
        
        guard let imageUrl = json["Poster"] as? String
              //let url = URL(string: imageLink)
        else{
            throw SerializationError.missing("imageLink")
        }
        
        /*URLSession.shared.dataTask(with: url){data, response, error in
            if let e = error {
                print("error download image \(e)")
            }else{
                if let imageData = data{
                    self.image = UIImage(data: imageData)
                }else{
                    print("error : type is not UIImage")
                }
            }
        }.resume()*/
        
        self.title = title
        self.description = description
        self.year = year
        self.imageUrl = imageUrl
    }
}

enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}

