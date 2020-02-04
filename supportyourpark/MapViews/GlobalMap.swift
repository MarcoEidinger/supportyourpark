import Foundation
import SwiftUI
import MapKit
import Combine
import CoreLocation

struct GlobalMap: UIViewRepresentable {

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: GlobalMap

        init(_ parent: GlobalMap) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

            guard !annotation.isKind(of: MKUserLocation.self) else {
                return nil
            }

            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "Yoo", for: annotation)
            annotationView.canShowCallout = true
            annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)

            return annotationView
        }

        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let selectedPark = parent.userData.parks
                .first(where: {
                        $0.locationCoordinate?.latitude == view.annotation?.coordinate.latitude &&
                        $0.locationCoordinate?.longitude == view.annotation?.coordinate.longitude
                }) else {
                return
            }
            parent.selectedPlace = selectedPark
            parent.showingPlaceDetails = true
        }
    }

    @EnvironmentObject private var userData: UserData

    @Binding var selectedPlace: Park?
    @Binding var showingPlaceDetails: Bool

    var locationManager = CLLocationManager()

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func setupManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func makeUIView(context: UIViewRepresentableContext<GlobalMap>) -> MKMapView {

        setupManager()

        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: "Yoo")

        let relevantParks = userData.parks.filter { $0.locationCoordinate != nil }
        relevantParks.forEach { park in
            let annotation = MKPointAnnotation()
            annotation.title = park.name
            annotation.subtitle = park.designation.rawValue
            annotation.coordinate = park.locationCoordinate!
            mapView.addAnnotation(annotation)
        }

        if locationManager.location != nil {
            var mapRegion = MKCoordinateRegion()
            mapRegion.center = locationManager.location!.coordinate
            mapRegion.span.latitudeDelta = 2.0
            mapRegion.span.longitudeDelta = 2.0

            mapView.setRegion(mapRegion, animated: true)
        }

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow

        return mapView
    }

    func updateUIView(_ view: MKMapView, context: UIViewRepresentableContext<GlobalMap>) {
    }
}

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var status: CLAuthorizationStatus? {
        willSet { objectWillChange.send() }
    }

    @Published var location: CLLocation? {
        willSet { objectWillChange.send() }
    }

    @Published var placemark: CLPlacemark? {
        willSet { objectWillChange.send() }
    }

    private let geocoder = CLGeocoder()

    override init() {
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    private func geocode() {
        guard let location = self.location else {
            return
        }
        geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
            if error == nil {
                self.placemark = places?[0]
            } else {
                self.placemark = nil
            }
        })
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location = location
        self.geocode()
    }
}

extension CLLocation {
    var latitude: Double {
        return self.coordinate.latitude
    }

    var longitude: Double {
        return self.coordinate.longitude
    }
}
