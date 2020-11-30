//
//  FavoriteView.swift
//  Restoranku
//
//  Created by mac on 27/11/20.
//

import SwiftUI
import SDWebImageSwiftUI
import CoreData

struct FavoriteView: View {
 
    @State var restaurants: [NSManagedObject] = []
    @State var restaurantCount: Int = 0
    
    var pictureImg = "https://restaurant-api.dicoding.dev/images/small"    
    var body: some View {
        HStack {
            if self.restaurantCount > 0 {
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(restaurants, id: \.self) { resto in
                            ZStack {
                                VStack(alignment: .leading) {
                                    ZStack(alignment: .bottomLeading) {
                                        let imgUrl = (resto as? RestaurantList)?.wrapperPicture ?? "error"
                                        WebImage(url: URL(string: "\(pictureImg)/\(imgUrl)"))
                                            .resizable()
                                            .indicator(.activity)
                                            .transition(.fade(duration: 0.5))
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width - 40, height: 180)
                                            .clipped()
                                            .cornerRadius(5)
                                        ZStack {
                                            HStack {
                                                Image(systemName: "mappin.circle.fill")
                                                    .font(.system(size: 14))
                                                Text((resto as? RestaurantList)?.wrapperCity ?? "error")
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
                                        .padding(.leading, 10)
                                        .padding(.bottom, 10)
                                    }
                                    VStack(alignment: .leading) {
                                        Text((resto as? RestaurantList)?.wrapperName ?? "error")
                                            .font(.title3)
                                        Text((resto as? RestaurantList)?.wrapperDesc ?? "error")
                                            .font(.system(size: 16))
                                            .lineLimit(2)
                                            .foregroundColor(Color("mySecondaryColorCustom"))
                                    }
                                }.frame(width: UIScreen.main.bounds.width - 40)
                            }.padding(10)
                        }
                    }
                }
            } else {
                VStack {
                    Image("cry")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                    Text("Favorite is Empty")
                        .font(.headline)
                        .bold()
                        .padding()
                }
                
            }
        }.onAppear {
            self.loadResto()
        }
        .navigationBarTitle(Text("My Favorite"), displayMode: .large)
    }
    
    func loadResto() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RestaurantList")
        
        do {
            restaurants = try managedContext.fetch(fetchRequest)
            restaurantCount = restaurants.count
        } catch {
            print("Could not fetch")
        }
    }
    
    func deleteResto(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "RestaurantList")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let fetchReturn = try managedContext.fetch(fetchRequest)
            
            guard let objectDelete = fetchReturn[0] as? NSManagedObject else {
                return
            }
            managedContext.delete(objectDelete)
            do {
                try managedContext.save()
                self.loadResto()
            } catch let error as NSError {
                print("could not delet \(error)")
            }
        } catch {
            print("gagal fetch")
        }
    }
}

//struct SearchBar: UIViewRepresentable {
//
//    @Binding var text: String
//
//    class Coordinator: NSObject, UISearchBarDelegate {
//
//        @Binding var text: String
//
//        init(text: Binding<String>) {
//            _text = text
//        }
//
//        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//            text = searchText
//        }
//
//    }
//
//    func makeCoordinator() -> SearchBar.Coordinator {
//        return Coordinator(text: $text)
//    }
//
//    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
//        let searchBar = UISearchBar(frame: .zero)
//        searchBar.delegate = context.coordinator
//        searchBar.searchBarStyle = .minimal
//        return searchBar
//    }
//
//    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
//        uiView.text = text
//    }
//
//}
