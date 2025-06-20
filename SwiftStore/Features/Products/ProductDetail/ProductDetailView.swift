//
//  ProductDetailView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/2/25.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    @StateObject private var favoritesManager = FavoritesManager.shared

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let url = viewModel.imageURL {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(Color.gray.opacity(0.1))
                }

                HStack {
                    Text(viewModel.title)
                        .font(.title)
                        .fontWeight(.bold)

                    Spacer()

                    Button {
                        FavoritesManager.shared.toggle(viewModel.product)
                    } label: {
                        Image(systemName: FavoritesManager.shared.contains(viewModel.product)
                              ? "heart.fill"
                              : "heart"
                        )
                        .foregroundColor(.red)
                        .font(.largeTitle)
                    }
                }

                Text(viewModel.price)
                    .font(.title2)
                    .foregroundColor(.secondary)

                Button {
                    CartManager.shared.add(viewModel.product)
                } label: {
                    Text("Add to Cart")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Product Detail")
    }
}

#Preview {
    let mockProd = Product(
        id: 1,
        title: "Sample Sneakers",
        price: 129.99,
        images: ["https://placehold.co/600x400"]
    )
    let viewModel = ProductDetailViewModel(product: mockProd)
    NavigationView {
        ProductDetailView(viewModel: viewModel)
    }
}
