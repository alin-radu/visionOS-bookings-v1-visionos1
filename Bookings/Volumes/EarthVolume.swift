import RealityKit
import RealityKitContent
import SwiftUI

import SwiftUI

struct EarthVolume: View {
    @State private var earth: Entity?

    var body: some View {
        RealityView { content in
            print("starting to load the Earth entity")

            // load the entity model
            guard let earthEntity = await RealityKitContent.entity(named: "EarthScene") else {
                print("Something went wrong with loading the Earth entity")
                return
            }

            // changing the size of the entity
            earthEntity.transform.scale = [2, 2, 2]

            // changing the starting position of the entity
            // earthEntity.transform.translation = [0, -0.4, 0.3]

            // start animation if exists, and is asociated with the entity
            // if let animation = earthEntity.availableAnimations.first {
            //     earthEntity.playAnimation(animation)
            // }

            print("add entity to content")
            // add entity to the RealityView
            content.add(earthEntity)

            earth = earthEntity
        }
    }
}

#Preview {
    EarthVolume()
}
