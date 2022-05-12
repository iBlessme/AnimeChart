//
//  ChartsAnime.swift
//  AnimBless
//
//  Created by iBlessme on 05.05.2022.
//

import SwiftUI

struct ChartsAnime: View {
    @EnvironmentObject var vm : TopAnimeVM
    
    
    var body: some View {
        NavigationView{
            VStack{
                Picker("Type", selection: $vm.typeSelection){
                    ForEach(0..<vm.listType.count, id:
                                \.self){
                        Text("\(vm.listType[$0])")
                    }
                }
                .pickerStyle(.segmented)
                .background(Color.purple.cornerRadius(5))
                .padding(.horizontal)
                HStack{
                    Spacer()
                    if vm.typeSelection == 0{
                        Picker("AnimeType", selection: $vm.animeTypeSection) {
                            ForEach(0..<vm.animeTypes.count, id:\.self) {
                                Text(vm.animeTypes[$0])
                            }
                        }
                        .onChange(of: vm.animeTypeSection) { tag in
                            vm.selectAnimeType(vm.animeTypes[tag])
                        }
                        .pickerStyle(.menu)
                        
                    }else{
                        Picker("MangaType", selection: $vm.mangaTypeSection) {
                            ForEach(0..<vm.mangaTypes.count, id:\.self) {
                                Text(vm.mangaTypes[$0])
                            }
                        }
                        .onChange(of: vm.mangaTypeSection) { tag in
                            vm.selectedMangaType(vm.mangaTypes[tag])
                        }
                        .pickerStyle(.menu)
                    }
                }
                
            }
            .background(Color.black.ignoresSafeArea())
        }
        
    }
    
}

struct ChartsAnime_Previews: PreviewProvider {
    static var previews: some View {
        ChartsAnime()
            .environmentObject(TopAnimeVM())
    }
}
