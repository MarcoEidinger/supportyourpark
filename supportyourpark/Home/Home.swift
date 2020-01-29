import SwiftUI

struct Home: View {

    @EnvironmentObject var userData: UserData

    var body: some View {
        TabView {
            FeaturedParks().environmentObject(userData)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("Parks")
                }.tag(0)
            Text("HelloWorld")
                .tabItem {
                    Image(systemName: "2.circle")
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
