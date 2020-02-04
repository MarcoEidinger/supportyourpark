import SwiftUI

struct Home: View {

    @EnvironmentObject var userData: UserData

    @State private var selectedPlace: Park?
    @State private var showingPlaceDetails = false

    var body: some View {
        TabView {
            FeaturedParks().environmentObject(userData)
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Parks")
                }.tag(0)
            
            GlobalMap(selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails).environmentObject(userData)
                .sheet(isPresented: $showingPlaceDetails, content: {
                    ParkDetail(
                        park: self.selectedPlace!
                    )
                })
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }.tag(1)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(UserData())
    }
}
