//
//  FavoritesView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/3/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject private var manager = FavoritesManager.shared

    var body: some View {
        NavigationView {
            if manager.items.isEmpty {
                VStack(spacing: 12) {
                    Text("❤️ No favorites yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text("Tab the heart on a product to add it here.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .multilineTextAlignment(.center)
                .padding()
            } else {
                List(manager.items) { item in
                    NavigationLink(
                        destination: ProductDetailView(
                            viewModel: ProductDetailViewModel(
                                product: Product(id: item.id,
                                                 title: item.title,
                                                 price: item.price,
                                                 images: [item.image])))
                    ) {
                        HStack(spacing: 16) {
                            AsyncImage(url: URL(string: item.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)

                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.headline)
                                    .lineLimit(1)
                                Text("$\(item.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            Button {
                                if let product = Product.fromFavorite(item) {
                                    manager.toggle(product)
                                }
                            } label: {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .navigationTitle("Favorites")
            }
        }
    }
}

#Preview {
    // Setup mock favorites for preview
    let favorites = FavoritesManager.shared
    favorites.clear()
    favorites.add(
        Product(id: 1,
                title: "Mock Shoes",
                price: 89.99,
                images: ["https://placehold.co/100x100"]
               )
    )

    return FavoritesView()
}
