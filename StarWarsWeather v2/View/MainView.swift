//
//  MainView.swift
//  StarWarsWeather v2
//
//  Created by Alex Peterson on 3/25/22.
//

import SwiftUI
import CoreLocation

struct MainView: View {
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    @State var temp: String = "10"
    @State var currentCondition: String = "Light snow"
    @State var planet: String = "HOTH"
    @State var funDescription: String = "Cold. It's freezing desolation."
    
    @State var searchField: String = ""
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                Button {
                    // TODO: get location clicked
                } label: {
                    Image(systemName: "location.circle.fill")
                        .font(Font.system(size: 36))
                        .foregroundColor(.black)
                }
                TextField("Search", text: $searchField)
                    .font(Font.system(size: 26))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                    )
                Button {
                    // TODO: search location clicked
                    weatherManager.fetchWeather(cityName: searchField)
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(Font.system(size: 36))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal, 10)
            VStack{
                Spacer()
                Text("Wow. \(temp)°F, \(currentCondition)?")
                    .font(Font.system(size: 27))
                Spacer()
                HStack {
                    Text("IT'S LIKE")
                        .font(Font.system(size: 17, weight: .bold))
                        .padding(.horizontal, 40)
                    Spacer()
                }
                Text("\(planet)")
                    .font(Font.custom("PingFangTC-Semibold", size: 64))
                    .padding(.vertical, 10)
                HStack {
                    Spacer()
                    Text("OUT THERE")
                        .font(Font.system(size: 17, weight: .bold))
                        .padding(.horizontal, 40)
                }
                Spacer()
                Text("\(funDescription)")
                    .font(Font.system(size: 27))
                Spacer()
            }
            
        }
        .background(
            Image("Hoth")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.vertical)
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
