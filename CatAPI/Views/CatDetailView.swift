//
//  CatDetailView.swift
//  CatAPI
//
//

import SwiftUI

struct CatDetailView: View {
    let cat : CatModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if cat.catImage != nil {
                    AsyncImage(url: URL(string: cat.catImage!.url)!) {
                        image in
                        image.resizable().scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Gewicht:     \(cat.weight.metric) kg")
                    Text("Lebenserwartung:     \(cat.lifeSpan) Jahre")
                    Text("Ursprung:      \(cat.origin)")
                    Text("Temperament:   \(cat.temperament ?? "")")
                    HStack {
                        Text("Hauskatze:    ")
                        cat.isIndoor ? Image(systemName: "checkmark").foregroundStyle(.green) : Image(systemName: "xmark").foregroundStyle(.red)
                    }.padding(.top,2)
                    
                    StarRatingView(rating: cat.intelligence ?? 0, label: "Intelligenz")
                    StarRatingView(rating: cat.childFriendly ?? 0, label: "Kinderfreundlich")
                    
                    Text("\(cat.description)").padding(.top,5)
                    
                    if cat.wikipediaURL != "" {
                        Link("Wikipedia", destination: URL(string: cat.wikipediaURL ?? "")!).padding(.top,2)
                    }
                    
                }.padding()
            }
            .navigationTitle(cat.name)
        }
    }
}

#Preview {
    NavigationStack {
        let cat : [CatModel] = PreviewData.load(filename: "CatModel")
        CatDetailView(cat: cat[0])
    }
}
