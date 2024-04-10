//
//  CatViewModel.swift
//  CatAPI
//
//

import Foundation

enum LoadState {
    case isLoading
    case isLoaded
}

@Observable
class CatViewModel {
    
    var cats : [CatModel] = []
    var loadState : LoadState = .isLoading
    var isError : Bool = false
    var errorMessage : String = ""
    
    let url = URL(string: "https://api.thecatapi.com/v1/breeds?api_key=\(api_key)")!
   
    
    func fetchCatsAsync() async throws {
        self.isError = false
        self.errorMessage = ""
        do {
            self.loadState = .isLoading
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let json = try decoder.decode([CatModel].self, from: data)
            self.cats = json
            self.loadState = .isLoaded
        } catch {
            self.loadState = .isLoaded
            self.isError = true
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
    
}


