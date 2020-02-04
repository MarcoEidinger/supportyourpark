import SwiftUI
import URLImage

struct ParkRow: View {
    var park: Park
    
    var body: some View {
        HStack {
            
            if park.imageURL != nil {
                // swiftlint:disable:next force_unwrapping
                URLImage(park.imageURL!,
                         delay: 0.10,
                         processors: [ Resize(size: CGSize(width: 50.0, height: 50.0), scale: UIScreen.main.scale) ],
                         content: {
                            $0.image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                })
                    .frame(width: 50.0, height: 50.0)
            }

            Text(park.name)
            
            Spacer()
        }
    }
}

struct ParkRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ParkRow(park: localParkData[0])
            ParkRow(park: localParkData[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
