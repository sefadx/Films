//
//  FilmNetwork.swift
//  Films
//
//  Created by Sefa DİNÇER on 23.08.2022.
//

import Foundation


class FilmNetwork{
    
    let baseUrl = "https://www.omdbapi.com/?apikey=ce3c6b74"
    
    func getName(filmName : String, completionHandler: @escaping (FilmModel?) -> Void){
        
        var film : FilmModel?
        
        let url = URL(string: "\(baseUrl)&t=\(filmName.replacingOccurrences(of: " ", with: "+"))")!
        URLSession.shared.dataTask(with: url){data, response, error in
            if let data = data {
                
                do{
                    if let json = try JSONSerialization.jsonObject(with: data ) as? [String : Any]{
                        film = try FilmModel.init(json: json)
                        completionHandler(film)
                    }
                } catch let error as NSError{
                    print("hata : \(error.localizedDescription)")
                    completionHandler(nil)
                }
            
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }.resume()
    }
    
}
