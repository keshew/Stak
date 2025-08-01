import SwiftUI

struct Workout: Identifiable {
    let id = UUID()
    let name: String
    let duration: String
    let imageName: String
    let progress: Double
    
    let description: String
    let difficulty: String
    let exercisesCount: Int
    let rating: Double
}

class GearProgressViewModel: ObservableObject {
    @Published var workouts: [Workout] = [
        Workout(
            name: "Jersey Care",
            duration: "15 mins",
            imageName: "tshirt.fill",
            progress: 0.7,
            description: "Proper jersey care involves gentle washing, air drying, and proper storage to maintain fabric quality and team colors.",
            difficulty: "Beginner",
            exercisesCount: 5,
            rating: 4.7
        ),
        Workout(
            name: "Cleat Maintenance",
            duration: "15 mins",
            imageName: "shoe",
            progress: 0.3,
            description: "Regular cleat maintenance includes cleaning, drying, and conditioning to extend their lifespan and performance.",
            difficulty: "Intermediate",
            exercisesCount: 4,
            rating: 4.3
        ),
        Workout(
            name: "Protective Gear",
            duration: "15 mins",
            imageName: "shield.fill",
            progress: 0.0,
            description: "Shin guards and protective equipment require regular cleaning and inspection for safety and hygiene.",
            difficulty: "Beginner",
            exercisesCount: 6,
            rating: 4.5
        ),
        Workout(
            name: "Bag Organization",
            duration: "15 mins",
            imageName: "bag.fill",
            progress: 0.5,
            description: "Keep your sports bag organized and clean to prevent odors and maintain equipment accessibility.",
            difficulty: "Beginner",
            exercisesCount: 5,
            rating: 4.4
        ),
        Workout(
            name: "Glove Care",
            duration: "15 mins",
            imageName: "hand.raised.fill",
            progress: 0.2,
            description: "Goalkeeper gloves need special care to maintain grip and prevent deterioration of latex materials.",
            difficulty: "Advanced",
            exercisesCount: 4,
            rating: 4.1
        ),
        Workout(
            name: "Accessory Cleaning",
            duration: "15 mins",
            imageName: "star.fill",
            progress: 0.8,
            description: "Clean and maintain all accessories like socks, caps, and other gear for optimal performance.",
            difficulty: "Beginner",
            exercisesCount: 5,
            rating: 4.6
        ),
        Workout(
            name: "Equipment Storage",
            duration: "15 mins",
            imageName: "archivebox.fill",
            progress: 0.4,
            description: "Proper storage techniques help preserve equipment quality and prevent damage during off-seasons.",
            difficulty: "Intermediate",
            exercisesCount: 3,
            rating: 4.5
        ),
        Workout(
            name: "Odor Prevention",
            duration: "15 mins",
            imageName: "leaf.fill",
            progress: 0.1,
            description: "Learn techniques to prevent and eliminate odors from sports equipment and gear.",
            difficulty: "Advanced",
            exercisesCount: 6,
            rating: 4.6
        ),
        Workout(
            name: "Stain Removal",
            duration: "15 mins",
            imageName: "drop.fill",
            progress: 0.0,
            description: "Effective stain removal techniques for various types of sports equipment and fabrics.",
            difficulty: "Advanced",
            exercisesCount: 7,
            rating: 4.7
        ),
        Workout(
            name: "Seasonal Care",
            duration: "15 mins",
            imageName: "calendar",
            progress: 0.3,
            description: "Seasonal maintenance routines to prepare equipment for different weather conditions.",
            difficulty: "Intermediate",
            exercisesCount: 3,
            rating: 4.3
        )
    ]

} 