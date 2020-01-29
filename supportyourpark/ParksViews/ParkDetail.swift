import SwiftUI

struct ParkDetail: View {
    @EnvironmentObject var userData: UserData
    var park: Park
    
    var parkIndex: Int {
        userData.parks.firstIndex(where: { $0.id == park.id })!
    }

    var body: some View {
        VStack {
            MapView(coordinate: park.locationCoordinate)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 200)
            
            CircleImage(image: park.image)
                .offset(x: 0, y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(park.name)
                        .font(.title)
                    
                    Button(action: {
                        self.userData.parks[self.parkIndex]
                            .isFavorite.toggle()
                    }) {
                        if self.userData.parks[self.parkIndex].isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                HStack(alignment: .top) {
                    Text(park.park)
                        .font(.subheadline)
                    Spacer()
                    Text(park.state)
                        .font(.subheadline)
                }

                Text(park.description)
                .font(.subheadline)
                .padding()
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ParkDetail_Preview: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return ParkDetail(park: userData.parks[0])
            .environmentObject(userData)
    }
}
