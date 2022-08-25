//
//  FilmDetails.swift
//  Films
//
//  Created by Sefa DİNÇER on 25.08.2022.
//

import SwiftUI

struct FilmDetail: View {
    
    @ObservedObject var urlImageModel :UrlImageModel
    
    var film : FilmModel
    
    init(film : FilmModel){
        self.urlImageModel = UrlImageModel(imageLink: film.imageUrl)
        self.film = film
    }
    
    var body: some View {
        ScrollView{
            VStack{
                Image(uiImage: self.urlImageModel.image ?? FilmCard.defaultImage!)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(4/5,contentMode: .fit)
                //.frame(width: 300, height: 300)
                HStack{
                    Text(film.title).font(.title).padding(.horizontal, 5).padding(.vertical, 10)
                }
                Text(film.description).font(.body)
            }
        }
    }
}
/*
 struct FilmDetails_Previews: PreviewProvider {
 static var previews: some View {
 FilmDetail()
 }
 }*/
