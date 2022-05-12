//
//  AnimeItemView.swift
//  AnimBless
//
//  Created by iBlessme on 06.05.2022.
//

import SwiftUI

struct AnimeItemView: View {
    var item: Anime
    var showRank = true
    
    
    var body: some View {
        VStack{
            let url = URL(string: item.images?["jpg"]?.imageURL ?? "")!
            ZStack {
                AsyncImage(url: url, content: { item in
                    item.resizable()
                        .scaledToFill()
                        .frame(height: 300)
                        .clipped()
                        .overlay(RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(.label), lineWidth: 0))
                        .shadow(radius: 5)
                        
                        
                }, placeholder: {
                    ProgressView()
            })
                Text("23")
            }
          Text("32")
        }
        
        .background(Color.purple.ignoresSafeArea())
        .cornerRadius(20)
        .padding()
    }
}

struct AnimeItemView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeItemView(item: Anime(id: 123, url: "https://myanimelist.net/anime/5114/Fullmetal_Alchemist__Brotherhood", images: ["jpg": CoverImage(imageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", smallImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg", largeImageURL: "https://cdn.myanimelist.net/images/anime/1223/96541.jpg")], trailer: nil, title: "test", titleEnglish: "test", titleJapanese: "測試", titleSynonyms: nil, type: nil, source: nil, episodes: nil, status: nil, airing: nil, aired: nil, duration: nil, rating: nil, score: 5.0, scoredBy: nil, rank: 1.0, popularity: nil, members: nil, favorites: nil, synopsis: nil, background: nil, season: nil, year: nil, broadcast: nil, producers: nil, licensors: nil, studios: nil, genres: nil, explicitGenres: nil, themes: nil, demographics: nil))
    }
}
