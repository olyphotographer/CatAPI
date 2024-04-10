//
//  ContentView.swift
//  CatApiTest
//
//

import SwiftUI

struct MainView: View {
    
    @State var catsVM = CatViewModel()
    @State var searchText : String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                switch catsVM.loadState {
                case .isLoading:
                    VStack {
                        ProgressView(label: {
                            Text("Please wait...")
                        })
                    }
                case .isLoaded:
                    VStack {
                        List {
                            ForEach(catsVM.cats.filter {
                                searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased())
                            }, id: \.id) {
                                cat in
                                NavigationLink(destination: CatDetailView(cat: cat)) {
                                    HStack {
                                        if cat.catImage != nil {
                                            AsyncImage(url: URL(string: cat.catImage!.url)!) {
                                                image in
                                                image.resizable().scaledToFit().frame(width: 100)
                                            } placeholder: {
                                                ProgressView()
                                            }
                                        }
                                        VStack(alignment: .leading) {
                                            Text(cat.name).font(.title3)
                                            Text("Gewicht \(cat.weight.metric) kg")
                                            Text("Ursprung \(cat.origin)")
                                            Spacer()
                                        }.padding()
                                    }
                                }
                                
                            }
                        }
                        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: .always)).textInputAutocapitalization(.never)
                        
                        .alert(isPresented: $catsVM.isError) {
                            Alert(title: Text("Error"), message: Text(catsVM.errorMessage), dismissButton: .default(Text("OK")))
                        }
                        
                        .refreshable(action: {
                            Task {
                                do {
                                    try await catsVM.fetchCatsAsync()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        })
                    }
                }
                
            }
            .navigationTitle("Katzen")
        }
        
        .task {
            do {
                try await catsVM.fetchCatsAsync()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    MainView()
}
