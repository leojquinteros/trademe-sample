//
//  ListingsView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 25/02/21.
//  Copyright © 2021 Leonel Quinteros. All rights reserved.
//

import SwiftUI

struct TMItemModel: Identifiable {
    var id = UUID()
    var name: String
}

struct ListingsView: View {
    
    var items: [TMItemModel] = [
        TMItemModel(name: "Property"),
        TMItemModel(name: "Automotor"),
        TMItemModel(name: "Jobs"),
        TMItemModel(name: "Clothing"),
        TMItemModel(name: "Fashion")
    ]
    
    var body: some View {
        NavigationView {
            List(items) { item in
                ListingNavigationItem(item: item)
            }
            .navigationBarTitle(Text("Item"))
        }
    }
}

struct ListingNavigationItem: View {
    
    let item: TMItemModel
    
    var body: some View {
        NavigationLink(destination: Text("Hola \(item.name)")) {
            Image(systemName: "cart")
            VStack(alignment: .leading) {
                Text(item.name)
            }
        }
    }
}

struct ListingsView_Previews: PreviewProvider {
    static var previews: some View {
        ListingsView()
    }
}
