import Foundation
import CoreLocation
import SwiftUI
import NatParkSwiftKit

let localParkData: [Park] = loadLocalParksFromFile()
let features = localParkData.filter { $0.isFeatured }

struct Parks: Decodable {
    let data: [NatParkSwiftKit.Park]
}

struct Simple: Decodable {
    let name: String
    let url: String
}

func loadDonationOptionsFromFile() -> [String: [DonationOption]] {
    let data: Data

    guard let file = Bundle.main.url(forResource: "parkDonationOptions.json", withExtension: nil)
    else {
        fatalError("Couldn't find parks.json in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load parks.json from main bundle:\n\(error)")
    }

    do {
        var parkDonationOptionMap: [String: [DonationOption]] = [:]
        let decoder = JSONDecoder()
        let parkDonationJSON = try decoder.decode([String:[Simple]].self, from: data)
//        guard let parkDonationJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any] else {
//            return [:]
//        }
        for keys in parkDonationJSON {
            let parkCode = keys.key
//            guard let options = keys.value else {
//                continue
//            }
            let donationOptions = keys.value.enumerated().map { (index, element) in
                return DonationOption(id: index, name: element.name, webLink: URL(string: element.url)!)
            }
            parkDonationOptionMap[parkCode] = donationOptions
        }
        return parkDonationOptionMap
    } catch {
        fatalError("Couldn't parse parks.json as Parks:\n\(error)")
    }
}

func loadLocalParksFromFile() -> [Park] {
    let data: Data

    guard let file = Bundle.main.url(forResource: "parks.json", withExtension: nil)
    else {
        fatalError("Couldn't find parks.json in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load parks.json from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        let parksInternalModel = try decoder.decode(Parks.self, from: data)
        let validParks = parksInternalModel.data.filter { $0.gpsLocation != nil }
        let parks = validParks.map { (park) -> Park in
            return Park(park)
        }
        return parks
    } catch {
        fatalError("Couldn't parse parks.json as Parks:\n\(error)")
    }
}
