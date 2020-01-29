import SwiftUI

struct ParkList: View {
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm : String = ""
    
    var body: some View {
        VStack {
            SearchBar(text: $searchTerm)

            List {

                Toggle(isOn: $userData.showFavoritesOnly) {
                    Text("Show Favorites Only")
                }

                ForEach(userData.parks.filter {
                    if searchTerm.isEmpty {
                        return true
                    } else {
                        return $0.name.contains(searchTerm)
                    }

                }) { park in
                    if !self.userData.showFavoritesOnly || park.isFavorite {
                        NavigationLink(
                            destination: ParkDetail(park: park)
                        ) {
                            ParkRow(park: park)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Parks"))
        }

    }
}

struct ParkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE", "iPhone XS Max"], id: \.self) { deviceName in
            NavigationView {
                ParkList()
                    .previewDevice(PreviewDevice(rawValue: deviceName))
                    .previewDisplayName(deviceName)
            }
        }
        .environmentObject(UserData())
    }
}
