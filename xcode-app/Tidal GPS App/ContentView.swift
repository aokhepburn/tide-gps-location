//
//  ContentView.swift
//  Tidal GPS App
//
//  Created by Alice Hepburn on 9/5/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            ForEach(viewModel.items) { item in
                Text(verbatim: item.name)
            }
        }
        .padding()
    }
}
extension ContentView {
    final class ViewModel: ObservableObject {
        let items: [Item] = [
            Item(name: "Hello"),
            Item(name: "World"),
            Item(name: "Whey Hey"),
            Item(name: "We are working now!"),
            Item(name: "See Daniel")
        ]
        func select(_: ContentView.Item) {
            // implement
        }
    }
    struct Item: Identifiable {
        let name: String
        var id: String { name }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
