//
//  ContentView.swift
//  VacationInvegas
//
//  Created by Swapnil Chatterjee on 25/06/24.
//

import SwiftUI
import Charts

struct SampleTripRating{
    let trip : Int
    let raitng : Int
    
    static let ratings :[SampleTripRating]=[
        SampleTripRating(trip: 1, raitng: 55),
        SampleTripRating(trip: 2, raitng: 27),
        SampleTripRating(trip: 3, raitng: 67),
        SampleTripRating(trip: 4, raitng: 72),
        SampleTripRating(trip: 5, raitng: 81),
    ]
}

struct TripsChart: View {
    var body: some View {
        Chart (SampleTripRating.ratings, id :\.trip){
            rating in
            BarMark(x: .value("Year",rating.trip), y: .value("Rating",rating.raitng))
            LinePlot( x:"Years",y:"Ratings"){
                x in
                return x * 6+50
            }
            .foregroundStyle(.purple)
            
        }
        .chartXScale(domain: 1...5)
        .chartYScale(domain :1...100)
        .padding()
//        .frame(height: 500)
    }
}

#Preview { 
    TripsChart()
}
