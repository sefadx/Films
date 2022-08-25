//
//  SwiftUIView.swift
//  Films
//
//  Created by Sefa DİNÇER on 23.08.2022.
//

import SwiftUI

class UrlImageModel : ObservableObject {
    @Published var image: UIImage?
    var imageLink : String?
    
    init(imageLink: String?) {
        self.imageLink = imageLink
        loadImage()
    }
    
    func loadImage(){
        loadImageFromUrl()
    }
    
    func loadImageFromUrl(){
        guard let link = imageLink
        else{
            return
        }
        
        let url = URL(string: link)!
        URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
            .resume()
        
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?){
        guard error == nil else{
            print("Error: \(error!)")
            return
        }
        
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data)
            else{
                return
            }
            
            self.image = loadedImage
            
        }
        
    }
    
}

struct FilmCard: View {
    var film : FilmModel
    //var name : String, description : String, year :String, imageUrl : String
    
    @ObservedObject var urlImageModel :UrlImageModel
    
    static var defaultImage = UIImage(systemName: "applelogo")
    
    /*init(name : String, description : String, year :String, imageUrl : String, onTap : @escaping ()->Void = {}){
     self.urlImageModel = UrlImageModel(imageLink: imageUrl)
     self.name = name
     self.description = description
     self.year = year
     self.imageUrl = imageUrl
     self.onTap = onTap
     }
     if self.urlImageModel.image != nil{
     self.film.imageUI = self.urlImageModel.image
     }
     */
    
    init(film : FilmModel){
        self.urlImageModel = UrlImageModel(imageLink: film.imageUrl)
        self.film = film
    }
    
    
    var body: some View {
        
        NavigationLink(
            destination: FilmDetail(film: film),
            label:{
                VStack{
                    HStack{
                        Spacer()
                        Text(self.film.title).foregroundColor(.white).font(.title2)
                        Spacer()
                        Text(self.film.year).foregroundColor(.white).font(.caption)
                    }
                    HStack{
                        //Image(systemName: "applelogo")
                        Image(uiImage: self.urlImageModel.image ?? FilmCard.defaultImage!)
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text(self.film.description)
                            .lineLimit(4)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }.frame(maxWidth: .infinity,alignment: .leading)
                }.padding()
                    .background(.black)
                    .cornerRadius(15)
            })
        
        
    }
}
/*
 struct FilmCard_Previews: PreviewProvider {
 static var previews: some View {
 FilmCard(name: "film adı", description: "film açıklaması", year: "2000",imageUrl: "https://m.media-amazon.com/images/M/MV5BNzQzMzJhZTEtOWM4NS00MTdhLTg0YjgtMjM4MDRkZjUwZDBlXkEyXkFqcGdeQXVyNjU0OTQ0OTY@._V1_SX300.jpg")
 }
 }*/
