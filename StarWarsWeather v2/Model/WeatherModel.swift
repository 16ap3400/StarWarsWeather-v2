//
//  WeatherModel.swift
//  Star Wars Weather
//
//  Created by Alex Peterson on 02/04/2021.
//  Copyright © 2021 Alex S Peterson. All rights reserved.
//

import Foundation
import SwiftUI

class WeatherModel: ObservableObject {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    init(conditionId: Int, cityName: String, temperature: Double, description: String) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
        self.description = description
    }

    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var article: String {
        switch temperature {
        case -100...0:
            return "Ouch, "
        case 0...32:
            return "Oh my, "
        case 32...60:
            return "Ahh, "
        case 60...85:
            return "Hmm, "
        case 85...130:
            return "Whew, "
        default:
            return "Okay, "
        }
    }
    
    var prePlanetText: String {
        return article + temperatureString + "° F, " + description + "?"
    }
    
    var fontColor: Color {
        switch planetName {
        case "Tatooine":
            return Color.white
        case "Mustafar":
            return Color.white
        case "Yavin 4":
            return Color.white
        case "Naboo":
            return Color.white
        case "Bespin":
            return Color.black
        case "Dagobah":
            return Color.white
        case "Endor":
            return Color.white
        case "Hoth":
            return Color.black
        case "Kamino":
            return Color.white
        default:
            return Color.green
        }
    }
    
    var conditionName: String {
        switch conditionId {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...332:
                return "cloud.drizzle"
            case 500...532:
                return "cloud.rain"
            case 600...632:
                return "cloud.snow"
            case 700...782:
                return "wind"
            case 800:
                return "sun.max"
            case 801...805:
                return "cloud"
            default:
                return "sun.min"
        }
    }
    
    var planetName: String {
        if(temperature < 32){
            return "Hoth"
        }else if(temperature < 70){
            switch conditionId {
                case 200...232:
                    return "Kamino"
                case 300...332:
                    return "Kamino"
                case 500...532:
                    return "Kamino"
                case 600...632:
                    return "Hoth"
                case 700...721:
                    return "Bespin"
                case 741:
                    return "Endor"
                case 751...771:
                    return "Mustafar"
                case 781:
                    return "Bespin"
                case 800:
                    return "Naboo"
                case 801:
                    return "Endor"
                case 802...803:
                    return "Yavin 4"
                default:
                    return "Yavin 4"
            }
        }else if (temperature < 100){
            switch conditionId {
                case 200...232:
                    return "Dagobah"
                case 300...332:
                    return "Dagobah"
                case 500...532:
                    return "Dagobah"
                case 600...632:
                    return "Hoth"
                case 700...721:
                    return "Dagobah"
                case 731:
                    return "Tatooine"
                case 741:
                    return "Dagobah"
                case 751:
                    return "Tatooine"
                case 752...771:
                    return "Tatooine"
                case 781:
                    return "Bespin"
                case 800:
                    return "Tatooine"
                case 801:
                    return "Tatooine"
                case 802...804:
                    return "Dagobah"
                default:
                    return "Tatooine"
            }
        }else{
            switch conditionId {
                case 200...232:
                    return "Dagobah"
                case 300...332:
                    return "Dagobah"
                case 500...532:
                    return "Dagobah"
                case 600...632:
                    return "Hoth"
                case 700...721:
                    return "Dagobah"
                case 731:
                    return "Tatooine"
                case 741:
                    return "Dagobah"
                case 751:
                    return "Tatooine"
                case 752...771:
                    return "Mustafar"
                case 781:
                    return "Bespin"
                case 800:
                    return "Mustafar"
                case 801:
                    return "Tatooine"
                case 802...804:
                    return "Dagobah"
                default:
                    return "Mustafar"
            }
        }
    }
    
    var planetCommentAfter: String {
        switch planetName {
        case "Mustafar":
            return "Sweltering."
        case "Tatooine":
            return "Hot, dry, occasional sarlacc."
        case "Kamino":
            return "Wet."
        case "Dagobah":
            return "Hot and wet, and not in a good way."
        case "Hoth":
            return "Cold. It's freezing desolation."
        case "Endor":
            return "Temperate, but grey \n and cloudy."
        case "Yavin 4":
            return "Hot but with some \n clouds in the sky."
        case "Naboo":
            return "Temperate, dry, \n and fairly pleasant."
        case "Bespin":
            return "Fog, mist, cloud. \n Can't see a thing."
        default:
            return "Try somewhere that exists."
        }
    }
}
