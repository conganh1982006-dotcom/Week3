import Foundation

enum SampleData {

    static let products: [Product] = [

        Product(
            id: "F01",
            name: "Neon Tetra",
            category: .fish,
            price: 25000,
            oldPrice: 32000,
            imageName: "fish_neon",
            description: "A small, colorful freshwater fish for planted community tanks.",
            stock: 35,
            rating: 4.8,
            isFeatured: true
        ),

        Product(
            id: "F02",
            name: "Halfmoon Betta",
            category: .fish,
            price: 120000,
            oldPrice: nil,
            imageName: "fish_betta",
            description: "A vibrant Betta with flowing fins, best kept in a calm tank.",
            stock: 12,
            rating: 4.9,
            isFeatured: true
        ),

        Product(
            id: "F03",
            name: "Guppy Fish",
            category: .fish,
            price: 20000,
            oldPrice: nil,
            imageName: "fish_guppy",
            description: "Easy-care small fish with bright, varied colors.",
            stock: 50,
            rating: 4.7,
            isFeatured: true
        ),

        Product(
            id: "F04",
            name: "Molly Fish",
            category: .fish,
            price: 35000,
            oldPrice: nil,
            imageName: "fish_molly",
            description: "A peaceful and beginner-friendly freshwater fish.",
            stock: 20,
            rating: 4.5,
            isFeatured: false
        ),

        Product(
            id: "P01",
            name: "Anubias Nana",
            category: .plants,
            price: 55000,
            oldPrice: 70000,
            imageName: "plant_anubias",
            description: "A hardy aquarium plant that can be attached to rocks or driftwood.",
            stock: 18,
            rating: 4.7,
            isFeatured: true
        ),

        Product(
            id: "P02",
            name: "Java Moss",
            category: .plants,
            price: 45000,
            oldPrice: nil,
            imageName: "plant_moss",
            description: "An easy aquatic moss that offers shelter for fry.",
            stock: 25,
            rating: 4.6,
            isFeatured: false
        ),

        Product(
            id: "D01",
            name: "Aquarium Stones",
            category: .decorations,
            price: 85000,
            oldPrice: nil,
            imageName: "decor_stone",
            description: "Decorative stones for natural aquascaping layouts.",
            stock: 16,
            rating: 4.7,
            isFeatured: false
        ),

        Product(
            id: "D02",
            name: "Aquarium Driftwood",
            category: .decorations,
            price: 95000,
            oldPrice: 120000,
            imageName: "decor_wood",
            description: "Natural driftwood for aquarium aquascapes.",
            stock: 10,
            rating: 4.8,
            isFeatured: true
        ),

        Product(
            id: "E01",
            name: "Mini Aquarium Filter",
            category: .equipment,
            price: 250000,
            oldPrice: 290000,
            imageName: "equipment_filter",
            description: "A compact filter for smaller fish tanks.",
            stock: 9,
            rating: 4.8,
            isFeatured: true
        ),

        Product(
            id: "E02",
            name: "Aquarium LED Light",
            category: .equipment,
            price: 180000,
            oldPrice: nil,
            imageName: "equipment_light",
            description: "An LED light for fish tanks and aquatic plants.",
            stock: 15,
            rating: 4.6,
            isFeatured: false
        ),

        Product(
            id: "T01",
            name: "Fish Food Pellets",
            category: .food,
            price: 65000,
            oldPrice: nil,
            imageName: "food_pellets",
            description: "Pellet food for a wide range of freshwater fish.",
            stock: 32,
            rating: 4.6,
            isFeatured: true
        ),

        Product(
            id: "T02",
            name: "Betta Fish Food",
            category: .food,
            price: 78000,
            oldPrice: nil,
            imageName: "food_betta",
            description: "Specially formulated food for Betta fish.",
            stock: 24,
            rating: 4.8,
            isFeatured: false
        ),

        Product(
            id: "A01",
            name: "Fish Net",
            category: .accessories,
            price: 30000,
            oldPrice: nil,
            imageName: "accessory_net",
            description: "A soft net for safely moving aquarium fish.",
            stock: 28,
            rating: 4.5,
            isFeatured: false
        ),

        Product(
            id: "A02",
            name: "Gravel Cleaner",
            category: .accessories,
            price: 85000,
            oldPrice: nil,
            imageName: "accessory_siphon",
            description: "A siphon tool for cleaning substrate and changing water.",
            stock: 17,
            rating: 4.7,
            isFeatured: false
        )
    ]
}
