import SwiftUI

struct ParkDetail: View {
    @EnvironmentObject var userData: UserData
    var park: Park
    
    var parkIndex: Int {
        userData.parks.firstIndex(where: { $0.id == park.id })!
    }

    var body: some View {
        VStack {
            if park.locationCoordinate != nil {
                MapView(coordinate: park.locationCoordinate!)
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: 200)
            }

            if park.imageURL != nil {
                CircleImage(imageURL: park.imageURL)
                    .offset(x: 0, y: -130)
                    .padding(.bottom, -130)
            }

            VStack(alignment: .leading) {
                HStack {
                    Text(park.name)
                        .font(.title)
                }
                
                HStack(alignment: .top) {
                    Text(park.designation.rawValue)
                        .font(.subheadline)
                    Spacer()
                    Text(park.state)
                        .font(.subheadline)
                }

                Text(park.description)
                    .font(.subheadline)
                    .padding()

                ForEach(park.donationOptions) { option in
                    ParkDonationButton(model: option)
                }
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
