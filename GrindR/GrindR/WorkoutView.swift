//
//  WorkoutView.swift
//  GrindR
//
//  Created by Molnár Krisztofer on 2022. 02. 18..
//

import SwiftUI

struct WorkoutView: View {
    @State private var dragAmount = CGSize.zero
    private var thresholdPercentage: CGFloat = 0.5
    var workout: Workout
    
    private var onRemove: (_ workout: Workout) -> Void
    
    private var onRemoveLeft: (_ workout: Workout) -> Void
    
    init(workout: Workout, onRemove: @escaping (_ workout: Workout) -> Void, onRemoveLeft: @escaping (_ workout: Workout) -> Void){
        self.workout = workout
        self.onRemove = onRemove
        self.onRemoveLeft = onRemoveLeft
    }
    
    private func getGesturePercentage(_ uisize: Double, from gesture: DragGesture.Value) -> CGFloat {
        gesture.translation.width / uisize
    }
    
    var body: some View {
            VStack{
                Image(workout.imageName)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(25)
                
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text(workout.workoutName)
                            .font(.title)
                            .bold()
                        Text("4 x \(workout.reps) reps")
                            .font(.subheadline)
                            .bold()
                    }
                    Spacer()
                    
                    Image("mini_icon")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.gray)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .background(Color(UIColor.lightGray))
            .cornerRadius(25)
            .shadow(radius: 10)
            .frame(maxWidth: UIScreen.main.bounds.size.width*0.95)
            .overlay(
                ZStack{
                    Image("dislike")
                        .renderingMode(.template)
                        .foregroundColor(Color.red)
                        .shadow(radius: 25)
                        .opacity((-dragAmount.width/100))
                    
                    Image("like")
                        .renderingMode(.template)
                        .foregroundColor(Color.green)
                        .shadow(radius: 25)
                        .opacity(dragAmount.width/100)
                    
                    //Image("superlike")
                    //    .renderingMode(.template)
                    //    .foregroundColor(Color.purple)
                    //    .shadow(radius: 25)
                    //    .opacity(-dragAmount.height/100)
                })
            .offset(dragAmount)
            .rotationEffect(Angle(degrees: dragAmount.width*0.1))
            .gesture(DragGesture()
                        .onChanged{
                dragAmount = $0.translation
            }
                        .onEnded{
                value in
                
                if abs(self.getGesturePercentage(UIScreen.main.bounds.size.width, from: value)) > self.thresholdPercentage{
                    if (dragAmount.width > 0 ){
                        self.onRemove(self.workout)
                    }
                    else{
                        self.onRemoveLeft(self.workout)
                    }
                }
                else{
                    withAnimation(.spring()){
                        dragAmount = .zero
                    }
                }
            })
        }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutView(workout: Workout(id:0, workoutName: "Placeholder", reps: 3, type: "Push", imageName: "placeholder"), onRemove: {_ in }, onRemoveLeft: {_ in })
    }
}
