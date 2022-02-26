//
//  ContentView.swift
//  GrindR
//
//  Created by Molnár Krisztofer on 2022. 02. 16..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack
            {
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                VStack
                {
                    Image("GrindR-logo")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                    NavigationLink(destination: MainPickerView(workoutList: []).navigationBarHidden(true))
                        {
                                Text("Begin the GRIND")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .background(Capsule()
                                                    .fill(Color.black)
                                                    .opacity(0.4)
                                                    .frame(width: 300, height: 50))
                                    .padding()
                                    .font(.system(size: 25))
                        }
                    Spacer()                        
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
