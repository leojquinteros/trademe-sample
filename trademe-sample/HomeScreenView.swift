//
//  HomeScreenView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 20/02/21.
//  Copyright © 2021 Leonel Quinteros. All rights reserved.
//

import SwiftUI

struct HomeScreenView: View {
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                Text("Search")
                Image(systemName: "magnifyingglass")
            }
            ListingsView()
                .tabItem {
                Text("Notifications")
                Image(systemName: "bell")
            }
            CategoriesView()
                .tabItem {
                Text("Watchlist")
                Image(systemName: "heart")
                    .accentColor(.blue)
                
            }
            AboutDeveloperView()
                .tabItem {
                Text("My Trade Me")
                Image(systemName: "person")
            }
        }
    }
}

struct SearchView: View {
    var body: some View {
        NavigationView {
            Text("Search")
            .navigationTitle("Search")
        }
    }
}

struct WatchlistView: View {
    var body: some View {
        NavigationView {
            Text("Watchlist empty")
            .navigationTitle("Watchlist")
        }
    }
}

struct MyTradeMeView: View {
    var body: some View {
        NavigationView {
            Text("My Trade Me")
            .navigationTitle("My Trade Me")
        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
