import SwiftUI
import URLImage

struct CategoryRow: View {
    var categoryName: String
    var items: [Park]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { park in
                        NavigationLink(
                            destination: ParkDetail(
                                park: park
                            )
                        ) {
                            CategoryItem(park: park)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

struct CategoryItem: View {
    var park: Park
    var body: some View {
        VStack(alignment: .leading) {
            if park.imageURL != nil {
                URLImage(park.imageURL!,
                    delay: 0.10,
                    processors: [ Resize(size: CGSize(width: 50.0, height: 50.0), scale: UIScreen.main.scale) ],
                    content:  {
                        $0.image
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 155, height: 155)
                        .cornerRadius(5)
                    })
                .frame(width: 155.0, height: 155.0)
            }
//            park.image
//                .renderingMode(.original)
//                .resizable()
//                .frame(width: 155, height: 155)
//                .cornerRadius(5)
            Text(park.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(
            categoryName: localParkData[0].category.rawValue,
            items: Array(localParkData.prefix(4))
        )
        .environmentObject(UserData())
    }
}
