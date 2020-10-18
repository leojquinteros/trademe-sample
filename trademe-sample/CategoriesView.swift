//
//  CategoriesView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 18/10/20.
//  Copyright © 2020 Leonel Quinteros. All rights reserved.
//

import SwiftUI

struct TMCategoryModel: Identifiable {
    var id = UUID()
    var name: String
    var itemCount: Int
}

#if DEBUG
let testData = [
    TMCategoryModel(name: "Property", itemCount: 14),
    TMCategoryModel(name: "Automotor", itemCount: 1),
    TMCategoryModel(name: "Jobs", itemCount: 23),
    TMCategoryModel(name: "Clothing", itemCount: 324),
    TMCategoryModel(name: "Fashion", itemCount: 22),
]
#endif

struct CategoriesView: View {
    
    var categories: [TMCategoryModel] = []
    
    var body: some View {
        
        NavigationView {
            List(categories) { category in
                CategoryNavigationItem(category: category)
            }
            .navigationBarTitle(Text("Categories"), displayMode: .inline)
        }
    }
}

#if DEBUG
struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoriesView(categories: testData).environment(\.colorScheme, .light)
            CategoriesView(categories: testData).environment(\.colorScheme, .dark)
        }
    }
}
#endif

struct CategoryNavigationItem: View {
    
    let category: TMCategoryModel
    
    var body: some View {
        NavigationLink(destination: Text("Hola \(category.name)")) {
            Image(systemName: "pencil.and.outline")
            VStack(alignment: .leading) {
                Text(category.name)
                Text("\(category.itemCount) items")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
