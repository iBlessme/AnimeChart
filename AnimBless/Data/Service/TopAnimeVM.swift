//
//  TopAnimeVM.swift
//  AnimBless
//
//  Created by iBlessme on 06.05.2022.
//

import Foundation

class TopAnimeVM: ObservableObject{
    
    @Published var typeSelection = 0
    @Published var animeTypeSection = 0
    @Published var mangaTypeSection = 0
    @Published var topAnimeList: [Anime] = [Anime]()
    @Published var topMangaList: [Manga] = [Manga]()
    @Published var isLoading = false
    
    let listType = ["Anime", "Manga"]
    let animeTypes = ["All", "TV", "Movie", "OVA", "Special", "ONA", "Music"]
    let mangaTypes = ["All", "Manga", "Novel", "LightNovel", "Oneshot", "Doujin", "Manhwa", "Manhua"]
    
    private var loadingAnimePage = 1
    private var loadingMangaPage = 1
    private var apiService: ApiServiceProtocol
    
    init(apiService: ApiServiceProtocol = ApiAnimeService()){
        self.apiService = apiService
    }
    
    func initTopAnime(){
        if topAnimeList.isEmpty{
            fetchTopAnime(type: nil, page: 1)
        }
        if topMangaList.isEmpty{
            fetchTopManga(type: nil, page: 1)
        }
    }
    
    func selectAnimeType(_ type: String){
        resetLoadedAnimeList()
        if type == "ALL"{
            fetchTopAnime(type: nil, page: 1)
        }
        else{
            fetchTopAnime(type: type, page: 1)
        }
    }
    
    func selectedMangaType(_ type: String){
        resetLoadedMangaList()
        if type == "ALL"{
            fetchTopManga(type: nil, page: 1)
        }
        else{
            fetchTopManga(type: type, page: 1)
        }
    }
    
    func fetchNextAnimePage(){
        fetchTopAnime(type: animeTypes[animeTypeSection], page: loadingAnimePage + 1)
        loadingAnimePage += 1
    }
    func fetchNextMangaPage(){
        fetchTopManga(type: mangaTypes[mangaTypeSection], page: loadingMangaPage + 1)
        loadingMangaPage += 1
    }
    
    func refreshCurrentList(){
        if typeSelection == 0{
            animeTypeSection != 0 ? fetchTopAnime(type: animeTypes[animeTypeSection], page: loadingAnimePage) : fetchTopAnime(type: nil, page: loadingAnimePage)
        }
        else{
            mangaTypeSection != 0 ? fetchTopManga(type: mangaTypes[mangaTypeSection], page: loadingMangaPage) : fetchTopManga(type: nil, page: loadingMangaPage)
        }
    }
    
    
    
    private func fetchTopAnime(type: String?, page: Int){
        isLoading = true
        
        apiService.fetchTopAnime(type: type, page: page, completionHandler: {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data{
                        var existingList = self.topAnimeList
                        var newList = [Anime]()
                        
                        for anime in topList{
                            if !existingList.contains(anime){
                                newList.append(anime)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        
                        self.topAnimeList = existingList.sorted(by: {$0.rank! < $1.rank!})
                        
                        
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
            }
        })
    }
    
    private func fetchTopManga(type: String?, page: Int){
        isLoading = true
        
        apiService.fetchTopManga(type: type, page: page, completionHandler: {[weak self] result in
            guard let self = self else {return}
            
            switch result {
            case let .success(response):
                DispatchQueue.main.async {
                    self.isLoading = false
                    if let topList = response.data{
                        var existingList = self.topMangaList
                        var newList = [Manga]()
                        
                        for manga in topList{
                            if !existingList.contains(manga){
                                newList.append(manga)
                            }
                        }
                        existingList.append(contentsOf: newList)
                        
                        self.topMangaList = existingList.sorted(by: {$0.rank! < $1.rank!})
                        
                        
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
            }
        })
    }
    
    
    
    
    
    
    ///
    ///Перезагрузка страниц
    ///
    private func resetLoadedAnimeList(){
        loadingAnimePage = 1
        topAnimeList.removeAll()
    }
    private func resetLoadedMangaList(){
        loadingMangaPage = 1
        topMangaList.removeAll()
    }
    
    private func resetLoadedList(){
        resetLoadedAnimeList()
        resetLoadedMangaList()
        
        
    }
    
    
}
