//
//  TestView2.swift
//  advanced-ios
//
//  Created by Harsh Patel on 10/06/24.
//

import SwiftUI

struct TestView2: View {
    var body: some View {
        View2()
    }
}

struct Product: Identifiable, Hashable {
    var id: Int
    let title: String
    let query: String
}

struct View2: View {
    var products: [Product] = [
        Product(id: 1, title: "t1", query: "q1"),
        Product(id: 2, title: "t2", query: "q2")
    ]
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            AppContainer {
                VStack {
                    Text("Navigate to t2")
                        .onTapGesture {
                            path.append("q2")
                        }
                    
                    List(products) { product in
                        NavigationLink(product.title, value: product)
                    }
                    
                }
            }
            .navigationDestination(for: String.self) { query in
                if query == "q1" {
                    SearchView(query: query)
                } else {
                    SearchView2(query: query, path: $path)
                }
                
            }
            .navigationDestination(for: Product.self) { product in
                ProductView(product: product)
                    .toolbar {
                        Button("Show similar") {
                            path.append(product.query)
                        }
                    }
            }
        }
    }
}

struct ProductView: View {
    let product: Product
    var body: some View {
        Text("\(product.title)")
    }
}

struct SearchView: View {
    let query: String
    
    var body: some View {
        Text("Search View 1: \(query)")
    }
}

struct SearchView2: View {
    let query: String
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Text("Search View 2: \(query)")
            Button(action: {
                path.removeLast(path.count)
            }, label: {
                Text("Home")
            })
        }
    }
}

struct View1: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<5) { idx in
                    NavigationLink("Select Number: \(idx)", value: idx)
                }

                ForEach(0..<5) { idx in
                    NavigationLink("Select String: \(idx)", value: String(idx))
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected the number \(selection)")
            }
            .navigationDestination(for: String.self) { selection in
                Text("You selected the string \(selection)")
            }
        }
    }
}

#Preview {
    TestView2()
}
