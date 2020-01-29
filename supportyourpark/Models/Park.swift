import SwiftUI
import CoreLocation
import NatParkSwiftKit

struct Park: Hashable, Decodable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String = ""
    var park: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool
    var description: String = "Meep"
    var imageURL: URL?

    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    var featureImage: Image? {
        guard isFeatured else { return nil }
        
        return Image(
            ImageStore.loadImage(name: "\(imageName)_feature"),
            scale: 2,
            label: Text(name))
    }

    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "National Park"
        case nationalMonument = "National Monument"
        case others = "Others"
    }

    init(_ internalModel: NatParkSwiftKit.Park) {
        self.id = Int(internalModel.id) ?? Int.random(in: 1..<10000)
        self.name = internalModel.name

        let flipCoin = Int.random(in: 1..<10)
        if flipCoin % 2 == 0 { // even
           self.imageName = "turtlerock"
        } else { // odd
           self.imageName = "silversalmoncreek"
        }

        self.coordinates = Coordinates(latitude: internalModel.gpsLocation!.coordinate.latitude, longitude: internalModel.gpsLocation!.coordinate.longitude)
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
        self.isFavorite = false

        self.description = internalModel.description

        guard let imageUrl = internalModel.images?.first?.url else {
            return
        }

        var imageUrlString = imageUrl.absoluteString
        imageUrlString = imageUrlString + "?width=200&quality=90&mode=crop"
        self.imageURL = URL(string: imageUrlString)

        return
    }

}

extension Park {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
