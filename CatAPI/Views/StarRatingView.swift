//
//  StarRatingView.swift
//  CatAPI
//
//

import SwiftUI

struct StarRatingView: View {
    
    let rating : Int
    let label : String
    
    @State var color : Color = .yellow
    
    var body: some View {
        if rating != 0 {
            HStack {
                Text(label)
                Spacer()
                ForEach(1..<6) { number in
                    Image(systemName: number <= rating ? "star.fill" : "star")
                        .foregroundColor(number <= rating ? color : .gray)
                }
            }.onAppear() {
                color = rating <= 2 ? .red : rating > 4 ? .green : .yellow
            }
        } else {
            EmptyView()
        }
    }
}

#Preview {
    StarRatingView(rating: 3, label: "Intelligence")
}
