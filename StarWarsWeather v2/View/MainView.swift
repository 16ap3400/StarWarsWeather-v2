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
    
    @ObservedObject var vm: MainViewModel = MainViewModel()
    @State var searchField: String = ""
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack{
                    HStack(alignment: .center){
                        Button {
                            // TODO: get location clicked
                            vm.requestLocation()
                        } label: {
                            Image(systemName: "location.circle.fill")
                                .font(Font.system(size: 36))
                                .foregroundColor(vm.weather.fontColor)
                        }
                        if #available(iOS 15.0, *) {
                            TextField("Search", text: $searchField)
                                .font(Font.system(size: 26))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                                .onSubmit {
                                    vm.fetchWeather(cityName: searchField)
                                }
                        } else {
                                // Fallback on earlier versions
                            TextField("Search", text: $searchField)
                                .font(Font.system(size: 26))
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                )
                        }
                        Button {
                            // TODO: search location clicked
                            vm.fetchWeather(cityName: searchField)
                            UIApplication.shared.endEditing()
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .font(Font.system(size: 36))
                                .foregroundColor(vm.weather.fontColor)
                        }
                    }.padding(.top, 20)
                    VStack(alignment: .center){
                        Text(vm.weather.prePlanetText)
                            .font(Font.system(size: 27))
                            .lineLimit(2)
                            .foregroundColor(vm.weather.fontColor)
                            .padding(.top, 36)
                        
                        HStack {
                            Text("IT'S LIKE")
                                .font(Font.system(size: 27, weight: .bold))
                                .foregroundColor(vm.weather.fontColor)
                                .padding(.horizontal, 40)
                                .padding(.top, 55)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("\(vm.weather.planetName)")
                                .font(Font.custom("PingFangTC-Semibold", size: 74))
                                .foregroundColor(vm.weather.fontColor)
                            Spacer()
                        }.padding(.vertical, 20)
                        HStack {
                            Spacer()
                            Text("OUT THERE")
                                .font(Font.system(size: 27, weight: .bold))
                                .foregroundColor(vm.weather.fontColor)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 55)

                        }
                        
                        Text("\(vm.weather.planetCommentAfter)")
                            .font(Font.system(size: 27))
                            .foregroundColor(vm.weather.fontColor)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(width: 300)
                        Spacer()
                    }
                    
                }
                .ignoresSafeArea(.keyboard)
                .padding(.horizontal)
                if vm.isLoading {
                    ProgressView()
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).frame(width: 75, height: 75).foregroundColor(Color.gray))
                }
            }
        }
        .background(
            Image("\(vm.weather.planetName)")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.vertical)
                .blur(radius: 4)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
