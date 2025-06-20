//
//  ProductListView.swift
//  SwiftStore
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.products) { product in
                        NavigationLink(
                            destination: ProductDetailView(
                            viewModel: ProductDetailViewModel(
                                product: product)
                            )
                        ) {
                            VStack(alignment: .leading) {
                                Text(product.title)
                                    .font(.headline)
                                Text("$\(product.price, specifier: "%.2f")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Product")
            .task {
                await viewModel.loadProducts()
            }
        }
    }
}

#Preview {
    ProductListView()
}
