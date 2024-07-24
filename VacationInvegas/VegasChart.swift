//
//  ContentView.swift
//  VacationInvegas
//
//  Created by Swapnil Chatterjee on 25/06/24.
//

import SwiftUI
import Charts

struct SampleRating{
    let place : String
    let raitng : Int
    
    static let ratings :[SampleRating]=[
        SampleRating(place: "Bellagio", raitng: 88),
        SampleRating(place: "Paris", raitng: 75),
        SampleRating(place: "Treasure Island", raitng: 33),
        SampleRating(place: "Excalibur", raitng: 99),
    ]
}

struct VegasChart: View {
    var body: some View {
        Chart (SampleRating.ratings, id :\.place){
            rating in SectorMark(angle : .value("Ratings",rating.raitng),
                                 innerRadius: .ratio(0.65),
                                 angularInset: 1
            )
            .cornerRadius(7)
            .foregroundStyle(by: .value ("Place",rating.place))
            
        }
        .padding()
        .frame(height: 500)
    }
}

#Preview { 
    VegasChart()
}
