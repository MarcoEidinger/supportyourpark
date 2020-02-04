import SwiftUI

struct ParkDonationButton: View {
    var model: DonationOption

    var body: some View {
        Button(action: {
            UIApplication.shared.open(self.model.webLink)
        }) {
            HStack {
                Text("Donate with \(model.name)")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("DarkGreen"), Color("LightGreen")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding()
        }
    }
}

struct DonateButton_Preview: PreviewProvider {
    static var previews: some View {
        // swiftlint:disable:next force_unwrapping
        let option = DonationOption(id: 0, name: "Yellowstone Foundation", webLink: URL(string: "https://www.google.com")!)
        return ParkDonationButton(model: option)
    }
}
