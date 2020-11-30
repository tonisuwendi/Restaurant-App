//
//  DetailView.swift
//  Restoranku
//
//  Created by mac on 25/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct DetailView: View {
    
    @ObservedObject var presenter: DetailPresenter
    
    @State var restaurantIsEmpty: Bool = true
    @State var showAlertMaps = false
    
    var pictureImg = "https://restaurant-api.dicoding.dev/images/small"
    var gMap = "https://google.com/map/search/"
    
    var body: some View {
        ZStack {
            if presenter.loadingState {
                VStack {
                    Text("Loading..")
                    ActivityIndicator()
                }
            } else {
                ScrollView(.vertical) {
                    VStack {
                        pictureRestaurant
                        content
                    }
                    .frame(width: UIScreen.main.bounds.width - 40)
                }
            }
        }
        .onAppear {
            loadResto()
        }
        .navigationBarTitle(Text(self.presenter.restaurant.name), displayMode: .large)
    }
    
    func loadResto() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestaurantList")
        fetchRequest.predicate = NSPredicate(format: "id = %@", self.presenter.restaurant.id)
        
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            if fetchReturn.count == 0 {
                restaurantIsEmpty = true
            } else {
                restaurantIsEmpty = false
            }
        } catch {
            print("Could not fetch")
        }
    }
}

extension DetailView {
    var pictureRestaurant: some View {
        WebImage(url: URL(string: "\(pictureImg)/\(self.presenter.restaurant.picture)"))
            .resizable()
            .indicator(.activity)
            .transition(.fade(duration: 0.5))
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width - 40, height: 180)
            .clipped()
            .cornerRadius(5)
    }
    
    var content: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    self.showAlertMaps = true
                }, label: { city })
                .alert(isPresented: $showAlertMaps) {
                    Alert(title: Text("Do you want to open \(self.presenter.restaurant.city) on the maps?"), primaryButton: .default(Text("Yes")) {
                        if let cityUrl = URL(string: "https://google.com/maps/search/\(self.presenter.restaurant.city)") {
                            UIApplication.shared.open(cityUrl)
                        }
                    }, secondaryButton: .cancel())
                }
                Spacer()
                if self.restaurantIsEmpty {
                    Button(action: {
                        self.addNewRestaurant()
                        self.loadResto()
                    }, label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.gray)
                            .font(.title)
                    })
                } else {
                    Button(action: {
                        self.deleteRestaurant()
                        self.loadResto()
                    }, label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    })
                }
            }
            Text("Description")
                .font(.title3)
                .padding(.top, 2)
            Text(self.presenter.restaurant.description)
                .font(.system(size: 16))
                .foregroundColor(Color("mySecondaryColorCustom"))
        }
        .padding(.top, 5)
    }
    
    var city: some View {
        HStack {
            Image(systemName: "mappin.circle.fill")
                .font(.system(size: 14))
            Text(self.presenter.restaurant.city)
                .bold()
                .font(.system(size: 14))
                .padding(.leading, -2)
        }
        .padding(.leading, 10)
        .padding(.bottom, 5)
        .padding(.trailing, 8)
        .padding(.top, 5)
        .background(Color.green)
        .foregroundColor(Color.white)
        .cornerRadius(5)
    }
    
    func addNewRestaurant() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "RestaurantList", in: managedContext)!
        
        let newRestaurant = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newRestaurant.setValue(self.presenter.restaurant.id, forKey: "id")
        newRestaurant.setValue(self.presenter.restaurant.name, forKey: "name")
        newRestaurant.setValue(self.presenter.restaurant.description, forKey: "desc")
        newRestaurant.setValue(self.presenter.restaurant.city, forKey: "city")
        newRestaurant.setValue(self.presenter.restaurant.picture, forKey: "picture")
        newRestaurant.setValue(self.presenter.restaurant.rating, forKey: "rating")
        
        do {
            try managedContext.save()
            print("Saved successfully")
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    func deleteRestaurant() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestaurantList")
        fetchRequest.predicate = NSPredicate(format: "id = %@", self.presenter.restaurant.id)
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            guard let objectDelete = fetchReturn[0] as? NSManagedObject else {
                return
            }
            managedContext.delete(objectDelete)
            do {
                try managedContext.save()
            } catch {
                print("could not delete")
            }
        } catch {
            print("Could not fetch")
        }
    }

}
