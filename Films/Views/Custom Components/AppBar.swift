//
//  AppBar.swift
//  Films
//
//  Created by Sefa DİNÇER on 23.08.2022.
//

import SwiftUI

struct AppBar: View {
    
    @Binding var searchText : String
    
    var searchOnPressed : ()-> Void = {}
    var textChanged : (Bool)-> Void = {value in}
    
    
    var body: some View {
        HStack{
            
            Text("Filmler").foregroundColor(.white).font(.title2)
            
            Rectangle().frame(width: 10,height: 0)
            
            TextField("film ara", text: $searchText, onEditingChanged: self.textChanged)
                .padding(.all,5).padding(.leading,10)
                .cornerRadius(15)
                .foregroundColor(.black)
                .background(.white).cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.red,lineWidth: 1))
                .frame(width: .infinity)
                .transition(.scale)
            
            Rectangle().frame(width: 0,height: 0)
            
            if searchText.isEmpty{
                
            }else{
                Button(action: searchOnPressed ){
                    
                    Image(systemName: "magnifyingglass").renderingMode(.original).foregroundColor(.white).font(.title2)
                    
                }.transition(.scale)
            }
        }.padding(.all,15)
            .background(Color.black)
        
        
    }
}
