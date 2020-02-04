import SwiftUI

struct FeaturedParks: View {
    var categories: [String: [Park]] {
        Dictionary(
            grouping: userData.parks,
            by: { $0.category.rawValue }
        )
    }

    var featured: [Park] {
        userData.parks.filter { $0.isFeatured }
    }

    @State var showingProfile = false
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List {

                ForEach(categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: self.categories[key]!)
                }
                .listRowInsets(EdgeInsets())

                NavigationLink(destination: ParkList()) {
                    Text("See All")
                }
            }
            .navigationBarTitle(Text("Featured"))
        }
    }
}

struct FeaturedParks_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedParks()
            .environmentObject(UserData())
    }
}
