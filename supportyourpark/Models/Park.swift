import SwiftUI
import CoreLocation
import NatParkSwiftKit

enum Category: String, CaseIterable, Codable, Hashable {
    case featured = "National Park"
    case nationalMonument = "National Monument"
    case others = "Others"
}

struct Park: Hashable, Decodable, Identifiable {
    var id: Int
    let parkCode: String
    var name: String
    fileprivate var coordinates: Coordinates?
    var state: String = ""
    var park: String
    var category: Category
    var isFeatured: Bool
    var description: String = "Meep"
    var imageURL: URL?
    var designation: ParkUnitDesignation

    var locationCoordinate: CLLocationCoordinate2D? {
        guard let coordinates = coordinates else {
            return nil
        }
        return CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    init(_ internalModel: NatParkSwiftKit.Park) {
        self.id = Int(internalModel.id) ?? Int.random(in: 1..<10000)
        self.name = internalModel.name

        if internalModel.gpsLocation != nil {
            self.coordinates = Coordinates(latitude: internalModel.gpsLocation!.coordinate.latitude, longitude: internalModel.gpsLocation!.coordinate.longitude)
        } else {
            self.coordinates = nil
        }

        self.state = internalModel.states.first?.name ?? ""
        self.park = internalModel.fullName
        self.isFeatured = false
        //self.category = park.designation

        switch internalModel.designation {
        case .nationalPark:
            self.category = .featured
            self.isFeatured = true
        case .nationalMonument:
            self.category = .nationalMonument
        default:
            self.category = .others
        }

        self.description = internalModel.description

        self.parkCode = internalModel.parkCode

        self.designation = internalModel.designation

        guard let imageUrl = internalModel.images?.first?.url else {
            return
        }

        let imageUrlString = imageUrl.absoluteString + "?width=300&quality=90&mode=crop"
        self.imageURL = URL(string: imageUrlString)

        return
    }
}

extension Park {
    // swiftlint:disable force_unwrapping
    var donationOptions: [DonationOption] {
        let all = loadDonationOptionsFromFile()
        let options = all[self.parkCode]
        return options ?? [DonationOption(id: 0, name: "National Park Foundation", webLink: URL(string: "https://donate.nationalparks.org/page/40194/donate/1")!)]
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
