//
//  MainPickerView.swift
//  GrindR
//
//  Created by Molnár Krisztofer on 2022. 02. 16..
//

import SwiftUI

class Workout: Hashable, CustomStringConvertible{
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher){
        hasher.combine(id)
        hasher.combine(workoutName)
        hasher.combine(reps)
    }
    
    var id: Int = 0
    var hashValue: Int = 0
    
    var workoutName: String = ""
    var reps: Int = 0
    var type: String = ""
    var imageName: String = "placeholder"
    
    var description: String{
        return "\(workoutName), reps: 4 x \(reps) (\(type))"
    }
    
    init(id: Int, workoutName: String, reps: Int, type: String, imageName: String){
        self.id = id
        self.workoutName = workoutName
        self.reps = reps
        self.type = type
        self.imageName = imageName
    }
}

class DbWorkout{
    static func MakeDb() -> [Workout]{
        let workouts: [Workout] = [
            Workout(id:0, workoutName: "Barbell bench press", reps: 12, type: "push/chest", imageName: "barbell_bench_press"),
            Workout(id:1, workoutName: "Barbell row", reps: 10, type: "pull/back", imageName: "barbell_row"),
            Workout(id:2, workoutName: "Biceps curl", reps: 12, type: "biceps", imageName: "biceps_curl"),
            Workout(id:3, workoutName: "Crunches", reps: 25, type: "abs", imageName: "crunches"),
            Workout(id:4, workoutName: "Dumbell fly", reps: 12, type: "push/chest", imageName: "dumbell_fly"),
            Workout(id:5, workoutName: "Hammer strength", reps: 10, type: "push/chest", imageName: "hammer_strength"),
            Workout(id:6, workoutName: "Lat pulldown", reps: 15, type: "pull/cback", imageName: "lat_pulldown"),
            Workout(id:7, workoutName: "Pullups", reps: 10, type: "pull/back", imageName: "pullup"),
            Workout(id:8, workoutName: "Seated cable row", reps: 15, type: "pull/back", imageName: "seated_cable_row"),
            Workout(id:9, workoutName: "Stiff arm pulldown", reps: 10, type: "pull/back", imageName: "stiff_pulldown"),
            Workout(id:10, workoutName: "Triceps cables", reps: 15, type: "triceps", imageName: "triceps_cables")
        ]
        
        return  workouts
    }
}

struct MainPickerView: View {
    @State private var dragAmount = CGSize.zero
    
    @State var workouts: [Workout] = DbWorkout.MakeDb()
    
    @State var workoutList: [Workout]?
    
    var body: some View {
        VStack{
            Text("Workouts")
                .font(.title)
            
            ZStack{
                if (workouts.count > 0)
                {
                    ForEach(self.workouts, id:\.self){
                        wrkout in
                        WorkoutView(workout: wrkout, onRemove: { removedWorkout in self.workouts.removeAll()
                            {
                                if ($0.id == removedWorkout.id)
                                {
                                    workoutList?.append(removedWorkout)
                                    return true
                                }
                                return false
                            }}, onRemoveLeft: { removedWorkout in self.workouts.removeAll()
                                {
                                    if ($0.id == removedWorkout.id)
                                    {
                                        return true
                                    }
                                    return false
                                }})
                            .animation(.spring(), value: 0)
                    }
                }
            }
            
            if (workouts.count == 0){
                Text("No more workouts")
                    .font(.title2)
                    .padding(UIScreen.main.bounds.width * 0.2)
                
                Spacer()
                
                Button(action: {
                    workoutList?.removeAll()
                    workouts = DbWorkout.MakeDb()
                })
                {
                    Image("refresh")
                        .resizable()
                        .scaledToFit()
                }

            }
            
            Spacer()
            
            Text("Number of workouts for today: \(workoutList?.count ?? 0)")
            
            HStack{
                Spacer()
                
                Button(action: {
                    if (workouts.count > 0){
                        workouts.removeLast()
                    }
                }){
                    Image("dislike")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.red)
                        .background(Circle())
                }
                .buttonStyle(.plain)
                .padding()
                
                Spacer()
                
                //Button(action: {}){
                //    Image("superlike")
                //        .resizable()
                //        .renderingMode(.template)
                //        .padding(5)
                //        .frame(width: 50, height: 50)
                //        .foregroundColor(Color.purple)
                //        .background(Circle())
                //        .padding()
                //}
                //.buttonStyle(.plain)
                
                Text("Press or Swipe")
                
                Spacer()
                
                Button(action: {
                    if (workouts.count > 0){
                        let wrkt = workouts.last
                        workoutList?.append(wrkt!)
                        
                        workouts.removeLast()
                    }
                }){
                    Image("like")
                        .resizable()
                        .renderingMode(.template)
                        .padding(5)
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                        .background(Circle())
                        .padding()
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            
            Spacer()
            HStack{
                Spacer()
                
                VStack{
                    Image(systemName: "house.fill")
                        .resizable()
                        .foregroundColor(Color.red)
                        .frame(width: 25, height: 25)
                    Text("GRIND").foregroundColor(Color.red)
                        .font(.title2)
                }
                
                Spacer()
                
                NavigationLink(destination: WorkoutsListView(workoutList: workoutList, workouts: workouts).navigationBarHidden(true)){
                    VStack{
                        Image(systemName: "heart")
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: 25, height: 25)
                        Text("Workouts").foregroundColor(Color.black)
                            .font(.title2)
                    }
                }
                Spacer()
            }
        }
    }
}

struct MainPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MainPickerView(workoutList: [])
    }
}
