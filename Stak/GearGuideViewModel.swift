import SwiftUI

class GearGuideViewModel: ObservableObject {
    let contact = GearGuideModel()
    @Published var pickedGallery = Gallery(image: "", title: "", text: "", detailedText: "", isDone: false)
    @Published var arrayOfGallery: [Gallery] = [] {
        didSet {
            saveToUserDefaults()
        }
    }
    
    private let userDefaultsKey = "GalleryState"
    
    init() {
        loadFromUserDefaults()
    }
    
    func toggleDone(for index: Int) {
        guard arrayOfGallery.indices.contains(index) else { return }
        arrayOfGallery[index].isDone.toggle()
    }
    
    private func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(arrayOfGallery) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([Gallery].self, from: data) {
            arrayOfGallery = decoded
        } else {
            arrayOfGallery = [
                Gallery(
                    image: "tshirt.fill",
                    title: "How to wash a football jersey",
                    text: "Turn inside out, wash in cold water on delicate cycle. No fabric softener!",
                    detailedText: """
            To properly wash a football jersey, first turn it inside out to protect the fabric and team colors. Use cold water on a delicate cycle to avoid damage. Avoid fabric softeners and air dry to prolong the lifespan. Never use a tumble dryer or ironing.

            Additionally, make sure to wash the jersey separately from other clothes to avoid color bleeding. Use mild detergent and avoid bleach which may damage the fibers. After washing, hang the jersey in a shaded, well-ventilated area to dry naturally. This helps preserve the colors and shape for longer use.
            """,
                    isDone: false
                ),
                Gallery(
                    image: "leaf.fill",
                    title: "How to remove odor from gear",
                    text: "Soak in baking soda or vinegar before washing — this kills bacteria.",
                    detailedText: """
            To eliminate gear odor, soak your equipment in a solution of baking soda or white vinegar before washing. The acidic nature helps kill bacteria responsible for the odor. Rinse thoroughly and air dry in sunlight whenever possible.

            It's recommended to let the gear soak for at least 30 minutes in the solution. For persistent odors, repeat the process or use a gentle antibacterial laundry additive. Always ensure the gear dries completely before storing to prevent mold re-growth and maintain freshness.
            """,
                    isDone: false
                ),
                Gallery(
                    image: "shoe",
                    title: "Cleat Care",
                    text: "Clean by hand, wipe dry, keep away from heat. Stuff with paper inside.",
                    detailedText: """
            Clean your cleats manually using a damp cloth and mild soap. Avoid placing them near heaters or direct sunlight as excessive heat damages materials. Stuff cleats with paper to maintain shape and absorb moisture after each use.

            Avoid using washing machines or dryers to clean cleats as it can deform or damage them. Regularly check the soles for wear and tear. For wet cleats, dry them at room temperature and change the paper stuffing as needed to keep them dry and fresh.
            """,
                    isDone: false
                ),
                Gallery(
                    image: "shield.fill",
                    title: "How to clean shin guards",
                    text: "Wipe with damp cloth and soap. Air dry completely before storing.",
                    detailedText: """
            Clean shin guards with a damp cloth and mild soap. Never machine wash them as it can damage the protective materials. Dry thoroughly before storing to prevent mold and odors.

            Make sure to inspect shin guards for any signs of wear before cleaning. Use a soft brush for stubborn dirt. Store shin guards in a cool, dry place after cleaning to maintain their protective qualities.
            """,
                    isDone: false
                ),
                Gallery(
                    image: "hand.raised.fill",
                    title: "How to care for goalkeeper gloves",
                    text: "Don't twist! Wrap in towel, dry away from sun.",
                    detailedText: """
            Avoid twisting goalkeeper gloves to remove water; this damages the latex. Instead, gently wrap them in a towel to absorb moisture. Dry in a cool, shaded area, away from direct sunlight to prevent rubber deterioration.

            Always ensure the gloves are cleaned after use and never left damp in bags. After drying, store gloves flat or open for better air circulation. Applying latex conditioner occasionally helps maintain their flexibility and grip performance over time.
            """,
                    isDone: false
                ),
                Gallery(
                    image: "bag.fill",
                    title: "Post-match gear care",
                    text: "Don't leave gear in bag — air it out first. Wash as soon as possible.",
                    detailedText: """
            After the match, do not immediately pack your gear into a bag. Let it air out in a ventilated place to reduce bacteria growth and odors. The sooner you wash it — the better to maintain freshness and prevent stains from setting.

            Avoid leaving sweaty gear in plastic bags overnight as this promotes bacteria and mold. If immediate washing is unavailable, rinse the gear with cold water and hang it to dry. Regular post-match care greatly extends the life of your sportswear and maintains hygiene.
            """,
                    isDone: false
                )
            ]
        }
    }
} 