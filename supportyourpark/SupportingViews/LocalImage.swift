//
//  LocalImage.swift
//  supportyourpark
//
//  Created by Eidinger, Marco on 2/7/20.
//  Copyright © 2020 Eidinger, Marco. All rights reserved.
//

import Foundation
import SwiftUI

struct LocalImage: View {
    var body: some View {
        Image("turtlerock")
        //.frame(width: 128, height: 128)
        .aspectRatio(contentMode: ContentMode.fit)
    }
}

struct LocalImage_Previews: PreviewProvider {
    static var previews: some View {
        LocalImage()
    }
}
