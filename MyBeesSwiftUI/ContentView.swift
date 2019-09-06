import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Location.allLocationsFetchRequest()) var locations: FetchedResults<Location>
    
    func createLocation() {
        let location = Location(context: managedObjectContext)
        location.name = "New Name"
        location.street = "New Street"
        location.color = .purple
        
        try! managedObjectContext.save()
    }
    
    var body: some View {
        NavigationView {
            List(locations) { location in
                LocationCell(location: location)
            }.navigationBarTitle("Locations")
                .navigationBarItems(leading: Button("Map") {}, trailing: Button("+") { self.createLocation()})
        }
        
    }
}

class LocationStore: ObservableObject {
    @Published var locations: [LocationViewModel]
    
    init(locations: [LocationViewModel] = []) {
        self.locations = locations
    }
}

class LocationViewModel: Identifiable {
    var name: String
    var street: String
    var color: UIColor
    
    init(name: String, street: String, color: UIColor) {
        self.name = name
        self.street = street
        self.color = color
    }
}

struct LocationCell: View {
    let location: Location
    
    var body: some View {
        HStack(spacing: 20) {
            ColorRectangle(color: location.color)
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.street)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ColorRectangle: View {
    let color: UIColor
    
    var body: some View {
        Rectangle()
            .frame(width: 40, height: 40)
            .foregroundColor(Color(color))
            .border(Color.black, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let testData = [
        LocationViewModel(name: "Hamburg", street: "Ochsenwerder Landscheideweg", color: .yellow),
        LocationViewModel(name: "Leezen", street: "Kastanienweg", color: .red)
    ]
    
    static var previews: some View {
        ContentView()
            .environment(\.sizeCategory, .extraExtraExtraLarge)
    }
}
