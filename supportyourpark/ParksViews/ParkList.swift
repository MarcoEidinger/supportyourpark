import SwiftUI

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

struct ParkList: View {
    @EnvironmentObject private var userData: UserData
    @State private var searchTerm: String = ""
    
    var body: some View {

        let filteredParks = self.userData.parks.filter {
            if self.searchTerm.isEmpty {
                return true
            } else {
                return $0.name.contains(self.searchTerm)
            }
        }
        let statesOfFilteredParks = filteredParks.map { $0.state }.filter { !$0.isEmpty }.removingDuplicates().sorted()

        return VStack {
            SearchBar(text: $searchTerm)

            List {

                ForEach(statesOfFilteredParks, id: \.self) { item in

                    Section(header: Text(item)) {
                        ForEach(filteredParks.filter {
                            if self.searchTerm.isEmpty {
                                return $0.state == item
                            } else {
                                return $0.state == item && $0.name.contains(self.searchTerm)
                            }
                        }) { park in
                            NavigationLink(
                                destination: ParkDetail(park: park)
                            ) {
                                ParkRow(park: park)
                            }
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
