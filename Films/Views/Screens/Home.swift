//
//  Home.swift
//  Films
//
//  Created by Sefa DİNÇER on 22.08.2022.
//

import SwiftUI

struct Home: View {
    
    var network : FilmNetwork = FilmNetwork()
    
    @State var searchText : String = ""
    
    @State var filmList : [FilmModel] = []
    
    
    
    var body: some View {
        VStack{
            AppBar(
                searchText: $searchText,
                searchOnPressed: {
                    withAnimation(){
                        network.getName(filmName: self.searchText){film in
                             if film != nil {
                                 print("film geldi")
                                 filmList.removeAll()
                                 filmList.append(film!)
                             }else{
                                 print("film gelmedi")
                                 filmList.removeAll()
                             }
                         }
                    }
                    
                })
            if filmList.isEmpty{
               
            }
            else{
                ScrollView{
                    ForEach(filmList, id: \.self){ film in
                        FilmCard(name: film.title, description: film.description, year: film.year, imageUrl: film.imageUrl).transition(.slide)
                    }.padding(.all,5)
                }.padding(.all,0)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
