//
//  SwiftUIView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct CartView: View {
    @StateObject private var viewModel = CartViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.items.isEmpty {
                    Text("🛒 Your cart is empty")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.items) { item in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(item.title)
                                    .font(.headline)

                                HStack {
                                    Button {
                                        viewModel.decrease(item)
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.blue)
                                    }

                                    Text("Qty: \(item.quantity)")
                                        .frame(width: 60)

                                    Button {
                                        viewModel.increase(item)
                                    } label: {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                    }

                                    Spacer()
                                    Text("$\(item.totalPrice, specifier: "%.2f")")
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: viewModel.remove)
                    }

                    HStack {
                        Text("Total:")
                            .font(.headline)
                        Spacer()
                        Text("$\(viewModel.totalPrice, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    .padding()

                    Button("Clear Cart") {
                        viewModel.clearCart()
                    }
                    .foregroundColor(.red)
                    .padding(.bottom, 16)
                }
            }
            .navigationTitle("Swift Cart")
        }
    }
}

#Preview {
    let product = Product(id: 99, title: "Preview Product", price: 49.99, images: [])
    let cart = CartManager.shared
    cart.clear()
    cart.add(product)
    cart.add(product)

    return CartView()
}
