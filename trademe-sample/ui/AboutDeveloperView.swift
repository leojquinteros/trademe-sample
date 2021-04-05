//
//  AboutDeveloperView.swift
//  trademe-sample
//
//  Created by Leonel Quinteros on 25/02/21.
//  Copyright © 2021 Leonel Quinteros. All rights reserved.
//

import SwiftUI

struct AboutDeveloperView: View {
    var body: some View {
        ZStack {
            //BackgroundView()
            VStack {
                Image("profilepic")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                
                Text("Leo Quinteros")
                    .font(.title)
                    .foregroundColor(.white)
                    .bold()
                
                Spacer().frame(height: 30)
                
                VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text("leojquinteros@gmail.com")
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    HStack {
                        Image(systemName: "phone.bubble.left")
                        Text("+64 021 034 4731")
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    HStack {
                        Image(systemName: "chevron.left.slash.chevron.right")
                        Text("github.com/leojquinteros")
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    HStack {
                        Image(systemName: "network")
                        Text("linkedin.com/leojquinteros")
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    Spacer().frame(height: 30)
                    
                    Button(action: {
                        print("Tapped")
                    }, label: {
                        Text("Let's collab")
                            .bold()
                            .frame(width: 260, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    })
                }
            }
        }
    }
}

struct BackgroundView: View {

    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [.black, .gray]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct AboutDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        AboutDeveloperView()
            .preferredColorScheme(.light)
    }
}
