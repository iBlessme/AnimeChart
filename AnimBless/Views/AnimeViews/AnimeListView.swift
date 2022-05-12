//
//  AnimeListView.swift
//  AnimBless
//
//  Created by iBlessme on 06.05.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct AnimeListView: View {
    @EnvironmentObject var vm : TopAnimeVM
    @State var showDetails = false
//    var item : Anime
    var showRank = true
    
    
    var body: some View {
        ScrollView{
            ForEach(vm.topAnimeList, id: \.id){ anime in
                VStack{
                    ZStack{
//                        WebImage(url: URL(string: "\(anime.images)"))
                        let url = URL(string: anime.images?["jpg"]?.imageURL ?? "")!
                        AsyncImage(url: url, content: { item in
                            item.resizable()
                                
                                
                        }, placeholder: {
                            ProgressView()
                        })
                    }
                }
            }
        }
        .background(Color.black.ignoresSafeArea())
    }
}

struct AnimeListView_Previews: PreviewProvider {
    static var previews: some View {
        AnimeListView()
            .environmentObject(TopAnimeVM())
    }
}
