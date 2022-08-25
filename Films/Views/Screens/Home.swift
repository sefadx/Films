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
    @State var launch : Bool = true
    @State var filmList : [FilmModel]? = []
    
    var body: some View {
        
        NavigationView{
            VStack{
                AppBar(
                    searchText: $searchText,
                    searchOnPressed: {
                        launch = false
                        
                        network.getName(filmName: self.searchText){film in
                            
                            if film != nil {
                                print("film geldi")
                                filmList = []
                                filmList!.append(film!)
                            }else{
                                print("film gelmedi")
                                filmList = nil
                            }
                            
                        }
                        
                    })
                if launch == true{
                    
                }else if filmList == nil{
                    VStack{
                        Spacer()
                        Text("Film bulunamadı").font(.body).foregroundColor(.white)
                        Spacer()
                    }
                }
                else{
                    ScrollView{
                        ForEach(filmList!, id: \.self){ film in
                            //FilmCard(name: film.title, description: film.description, year: film.year, imageUrl: film.imageUrl)
                            FilmCard(film: film)
                            
                        }.padding(.all,5)
                    }.padding(.all,0)
                }
            }.navigationBarHidden(true)
        }
        
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
