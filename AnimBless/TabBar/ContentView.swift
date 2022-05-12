//
//  ContentView.swift
//  AnimBless
//
//  Created by iBlessme on 05.05.2022.
//

import SwiftUI



let items = [BottombarItem(icon: "list.star", title: "топ-аниме", color: .purple), BottombarItem(icon: "hand.thumbsup.fill", title: "ваш топ", color: .pink), BottombarItem(icon: "list.and.film", title: "список аниме", color: .blue)]


struct ContentView: View {
    @StateObject var vm = TopAnimeVM()
    
    @State var selectedIndex: Int = 0
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    var selectedItem: BottombarItem{
        items[selectedIndex]
    }
    
    var body: some View {
        NavigationView{
            VStack{
                if selectedIndex == 0{
                    ChartsAnime()
                        .environmentObject(vm)
                }
                else if selectedIndex == 1{
                    RatingAnime()
                        .environmentObject(vm)
                }
                else{
                    AnimeList()
                        .environmentObject(vm)
                }
                BottomBar(selectedIndex: $selectedIndex, items: items)
                    
            }
            .background(Color.black.ignoresSafeArea())
            
            
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


