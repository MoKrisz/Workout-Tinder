//
//  WorkoutsListView.swift
//  GrindR
//
//  Created by Molnár Krisztofer on 2022. 02. 18..
//

import SwiftUI

struct WorkoutsListView: View {
    @State var workoutList: [Workout]?
    @State var workouts: [Workout]
    
    var body: some View {
        VStack{
            List{
                ScrollView(.vertical){
                    ForEach(self.workoutList!, id:\.self){
                        swipedWorkout in
                        HStack{
                            Image(swipedWorkout.imageName)
                                .resizable()
                                .scaledToFit()
                            
                            Text(swipedWorkout.description)
                        }
                        .padding(.bottom)
                    }
                }
                .frame(height: UIScreen.main.bounds.height*0.65)
            }
            
            Text("Number of workouts: \(workoutList?.count ?? 0)")
            HStack{
                Spacer()
                NavigationLink(destination: MainPickerView(workouts: workouts, workoutList: workoutList).navigationBarHidden(true)){
                    VStack{
                        Image(systemName: "house")
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: 25, height: 25)
                        Text("GRIND").foregroundColor(Color.black)
                            .font(.title2)
                    }
                }
                
                Spacer()
                
                    VStack{
                        Image(systemName: "heart.fill")
                            .resizable()
                            .foregroundColor(Color.red)
                            .frame(width: 25, height: 25)
                        Text("Workouts").foregroundColor(Color.red)
                            .font(.title2)
                    }
            
                Spacer()
            }
        }
    }
}

struct WorkoutsListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsListView(workoutList: [], workouts: [])
    }
}
