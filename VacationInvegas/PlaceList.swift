//
//  ContentView.swift
//  VacationInvegas
//
//  Created by Swapnil Chatterjee on 25/06/24.
//

import SwiftUI
import SwiftData
import MapKit
struct PlaceList: View {
    @Query(sort:\Place.name) private var places :[Place]
    
    @State private var showImages = false
    
    @State private var searchTest = ""
    @State private var filterByInterested = false
    @Namespace var namespace
    private var predicate: Predicate<Place>{
        #Predicate<Place>{
            if !searchTest.isEmpty && filterByInterested{
                $0.name.localizedStandardContains(searchTest) &&
                $0.interested
            } else if !searchTest.isEmpty{
                $0.name.localizedStandardContains(searchTest)
            }else if filterByInterested {
                $0.interested
            }
            
            else{
                true
            }
        }
    }
    var body: some View {
        
        NavigationStack{
            List((try? places.filter(predicate)) ?? places){
                place in
                NavigationLink(value:place){
                    
                    HStack{
                        place.image
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 7))
                            .frame(width: 100,height: 100)
                        Text(place.name)
                        Spacer()
                        
                        if place.interested {
                            Image(systemName :"star.fill")
                                .foregroundStyle(.yellow)
                                .padding(.trailing)
                        }
                    }
                }
                .matchedTransitionSource(id: 1, in: namespace)
                .swipeActions(edge:.leading){
                    Button(place.interested  ? "Interested":"Not Interested",systemImage:"star"){
                        place.interested.toggle();
                    }
                    .tint(place.interested ? .yellow:.gray)
                }
            }
            .navigationTitle("Places")
            .searchable(text: $searchTest,prompt:"Find a Place")
            .animation(.default , value :searchTest)
            .navigationDestination(for: Place.self){
                place in MapView(place: place, position: .camera(MapCamera(centerCoordinate:place.location, distance: 1000,
                                                                                     heading: 250,pitch: 80
                                                                                     )))
                
                .navigationTransition(.zoom(sourceID:1, in : namespace))
            }
            .toolbar{
                
                ToolbarItem(placement :.topBarTrailing){
                    Button("Show Images", systemImage: "photo"){
                        showImages.toggle()
                    }
                
                    
                }
                ToolbarItem(placement :.topBarLeading){
                    Button("Filter", systemImage: filterByInterested ? "star.fill": "star"){
                        withAnimation{
                            filterByInterested.toggle()
                        
                        }
                    }.tint(filterByInterested ? .yellow:.blue)
                }
                
            }.sheet(isPresented: $showImages){
                Scrolling()
            }
            
        }
    }
}

#Preview { 
    PlaceList()
        .modelContainer(Place.preview)
}
