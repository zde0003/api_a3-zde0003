//
// ContentView.swift : Assignment3
//
// Copyright © 2023 Auburn University.
// All Rights Reserved.


import SwiftUI

struct Cards: View {
    
    @ObservedObject var cardVM = CardViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(cardVM.cardData) { card in
                    NavigationLink {
                        CardDetail(card: card)
                    } label: {
                        Text(card.name)
                    }
                }
            }
            .task {
                await cardVM.fetchData()
            }
            .listStyle(.grouped)
            .navigationTitle("Yu-Gi-Oh Cards")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Cards()
    }
}
