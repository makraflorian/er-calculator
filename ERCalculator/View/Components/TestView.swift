//
//  TestView.swift
//  ERCalculator
//
//  Created by Makra Flórián Róbert on 2023. 09. 26..
//

import SwiftUI
import SwiftData
import CoreData

@Model
class Weapon: Codable {
    enum CodingKeys: CodingKey {
        case weaponId, name, affinityId, weaponAffinities
    }
    
    @Attribute(.unique)
    var weaponId: Int
    var name: String
    var affinityId: Int
    var weaponAffinities: [WeaponAffinity]?
    
    init(weaponId: Int, name: String, affinityId: Int, weaponAffinities: [WeaponAffinity]) {
        self.weaponId = weaponId
        self.name = name
        self.affinityId = affinityId
        self.weaponAffinities = weaponAffinities
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weaponId = try container.decode(Int.self, forKey: .weaponId)
        self.name = try container.decode(String.self, forKey: .name)
        self.affinityId = try container.decode(Int.self, forKey: .affinityId)
        self.weaponAffinities = try container.decodeIfPresent([WeaponAffinity].self, forKey: .weaponAffinities)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(weaponId, forKey: .weaponId)
        try container.encode(name, forKey: .name)
        try container.encode(affinityId, forKey: .affinityId)
        try container.encode(weaponAffinities, forKey: .weaponAffinities)
    }
}

@Model
class WeaponAffinity: Codable {
    enum CodingKeys: CodingKey {
        case weaponId, name, attackBasePhysics, attackBaseMagic, attackBaseFire, attackBaseThunder, attackBaseDark, correctStrength, correctAgility, correctMagic, correctFaith, correctLuck, sortId, weight, reinforceTypeId, affinityId
    }
    
    @Attribute(.unique)
    var weaponId: Int
    var name: String
    var attackBasePhysics: Int
    var attackBaseMagic: Int
    var attackBaseFire: Int
    var attackBaseThunder: Int
    var attackBaseDark: Int
    var correctStrength: Int
    var correctAgility: Int
    var correctMagic: Int
    var correctFaith: Int
    var correctLuck: Int
    var sortId: Int
    var weight: Double
    var reinforceTypeId: Int
    var affinityId: Int
    
    init(weaponId: Int, name: String, attackBasePhysics: Int, attackBaseMagic: Int, attackBaseFire: Int, attackBaseThunder: Int, attackBaseDark: Int, correctStrength: Int, correctAgility: Int, correctMagic: Int, correctFaith: Int, correctLuck: Int, sortId: Int, weight: Double, reinforceTypeId: Int, affinityId: Int) {
        self.weaponId = weaponId
        self.name = name
        self.attackBasePhysics = attackBasePhysics
        self.attackBaseMagic = attackBaseMagic
        self.attackBaseFire = attackBaseFire
        self.attackBaseThunder = attackBaseThunder
        self.attackBaseDark = attackBaseDark
        self.correctStrength = correctStrength
        self.correctAgility = correctAgility
        self.correctMagic = correctMagic
        self.correctFaith = correctFaith
        self.correctLuck = correctLuck
        self.sortId = sortId
        self.weight = weight
        self.reinforceTypeId = reinforceTypeId
        self.affinityId = affinityId
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.weaponId = try container.decode(Int.self, forKey: .weaponId)
        self.name = try container.decode(String.self, forKey: .name)
        self.attackBasePhysics = try container.decode(Int.self, forKey: .attackBasePhysics)
        self.attackBaseMagic = try container.decode(Int.self, forKey: .attackBaseMagic)
        self.attackBaseFire = try container.decode(Int.self, forKey: .attackBaseFire)
        self.attackBaseThunder = try container.decode(Int.self, forKey: .attackBaseThunder)
        self.attackBaseDark = try container.decode(Int.self, forKey: .attackBaseDark)
        self.correctStrength = try container.decode(Int.self, forKey: .correctStrength)
        self.correctAgility = try container.decode(Int.self, forKey: .correctAgility)
        self.correctMagic = try container.decode(Int.self, forKey: .correctMagic)
        self.correctFaith = try container.decode(Int.self, forKey: .correctFaith)
        self.correctLuck = try container.decode(Int.self, forKey: .correctLuck)
        self.sortId = try container.decode(Int.self, forKey: .sortId)
        self.weight = try container.decode(Double.self, forKey: .weight)
        self.reinforceTypeId = try container.decode(Int.self, forKey: .reinforceTypeId)
        self.affinityId = try container.decode(Int.self, forKey: .affinityId)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(weaponId, forKey: .weaponId)
        try container.encode(name, forKey: .name)
        try container.encode(attackBasePhysics, forKey: .attackBasePhysics)
        try container.encode(attackBaseMagic, forKey: .attackBaseMagic)
        try container.encode(attackBaseFire, forKey: .attackBaseFire)
        try container.encode(attackBaseThunder, forKey: .attackBaseThunder)
        try container.encode(attackBaseDark, forKey: .attackBaseDark)
        try container.encode(correctStrength, forKey: .correctStrength)
        try container.encode(correctAgility, forKey: .correctAgility)
        try container.encode(correctMagic, forKey: .correctMagic)
        try container.encode(correctFaith, forKey: .correctFaith)
        try container.encode(sortId, forKey: .sortId)
        try container.encode(weight, forKey: .weight)
        try container.encode(reinforceTypeId, forKey: .reinforceTypeId)
        try container.encode(affinityId, forKey: .affinityId)
    }
}
//po NSHomeDirectory()
struct UsersView: View {
    @Query(sort: \Weapon.weaponId) var weapons: [Weapon]
    
    var body: some View {
        NavigationStack {
            List(weapons){ item in
                NavigationLink {
//                    TypeView(weapons: item.weaponAffinities ?? [])
                    TypeView(affinityId: item.affinityId)
                } label: {
                    Text(item.name)
                }
            }
        }
    }
}

struct TypeView: View {
//    let weapons: [WeaponAffinity]
    @Environment(\.modelContext) var modelContext
    @Query var weapons: [WeaponAffinity]
    
    init(affinityId: Int){
        self._weapons = Query(filter: #Predicate<WeaponAffinity> {
            $0.affinityId == affinityId }, sort: \.weaponId)
    }
    
    var body: some View {
        List(weapons) { weapon in
            Text(weapon.name)
        }
    }
}

struct TestView: View {
    //    @Query var weapons: [Weapon]
    
    var body: some View {
        UsersView()
//            .modelContainer(for: Weapon.self, isAutosaveEnabled: false) { result in
//                do {
//                    
//                    let container = try result.get()
//                    //                    container.migrationPlan
//                    
//                    //                     Check we haven't already added our users.
//                    let descriptor = FetchDescriptor<Weapon>()
//                    let existingUsers = try container.mainContext.fetchCount(descriptor)
//                    guard existingUsers == 0 else { return }
//                    
//                    // Load and decode the JSON.
//                    let weapons = DefaultsJSON.decode(from: "weapons", type: [Weapon].self)
//                    let weaponAffinities = DefaultsJSON.decode(from: "weaponAffinities", type: [WeaponAffinity].self)
//                    
//                    weaponAffinities?.forEach { container.mainContext.insert($0) }
//                    //                    weapons = weapons.sorted { $0.id < $1.id }
//                    
//                    // Add all our data to the context.
//                    weapons?.forEach { weapon in
//                        container.mainContext.insert(weapon)
//                        weapon.weaponAffinities?.append(contentsOf: weaponAffinities?.filter({ $0.affinityId == weapon.affinityId }) ?? [])
//                        print(weapon.weaponId)
//                    }
//
//                    try container.mainContext.save()
//                } catch {
//                    print("Failed to pre-seed database.")
//                }
//            }
    }
}

actor ItemsContainer {
    
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Weapon.self])
        let configuration = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [configuration])
        if shouldCreateDefaults {
            shouldCreateDefaults = false
            
            let weapons = DefaultsJSON.decode(from: "weapons", type: [Weapon].self)
            let weaponAffinities = DefaultsJSON.decode(from: "weaponAffinities", type: [WeaponAffinity].self)
            
            weaponAffinities?.forEach { container.mainContext.insert($0) }
         
            weapons?.forEach { weapon in
                container.mainContext.insert(weapon)
                weapon.weaponAffinities?.append(contentsOf: weaponAffinities?.filter({ $0.affinityId == weapon.affinityId }) ?? [])
                print(weapon.weaponId)
            }

        }

        return container
    }
    
}

struct DefaultsJSON {
    
    static func decode<T: Codable>(from fileName: String, type: T.Type) -> T? {
       
        do {
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return nil
            }
            
            let result = try JSONDecoder().decode(T.self, from: data)
            
            return result
        } catch {
            print(error)
            return nil
        }

    }
}








// MARK: - ASDSADSDA

//@Model
//class User {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//struct UsersViewRead: View {
//    @Query var weapons: [Weapon]
//
//    var body: some View {
//        NavigationStack {
//            List(weapons) { weapon in
//                Text("\(weapon.id)")
//            }
//            .navigationTitle("Weapons")
//        }
//    }
//}
//
//struct TestViewRead: View {
//    var body: some View {
//            VStack {
//                Button("Create Data") { create() }
//            }
//        }
//
//        func create() {
//            // Load our data model
//            let container = NSPersistentContainer(name: "Model")
//
//            // Write to a specific store filename, for easier deletion and copying.
//            let storeURL = URL.documentsDirectory.appending(path: "users.store")
//
//            if let description = container.persistentStoreDescriptions.first {
//                // Delete all existing data.
//                try? FileManager.default.removeItem(at: storeURL)
//
//                // Make Core Data write to our new store URL.
//                description.url = storeURL
//
//                // Force WAL mode off.
//                description.setValue("DELETE" as NSObject, forPragmaNamed: "journal_mode")
//            }
//
//            let users = [User(name: "asd"), User(name: "asd2"), User(name: "asd3")]
//
//            container.loadPersistentStores { description, error in
//                do {
//                    // Add all your pre-fill data here.
//                    for i in 1...10_000 {
//                        let user = Weapon(context: container.viewContext)
////                        user.name = "User \(i)"
//                        container.viewContext.insert(user)
//                    }
//
//                    // Ensure all our changes are fully saved.
//                    try container.viewContext.save()
//
//                    // Adjust this to the actual location where you want the file to be saved.
//                    let destination = URL(filePath: "/Users/twostraws/Desktop/users.store")
//                    try FileManager.default.copyItem(at: storeURL, to: destination)
//                } catch {
//                    print("Failed to create data: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
//
////struct TestView_Previews: PreviewProvider {
////    static var previews: some View {
////        TestView()
////    }
////}
