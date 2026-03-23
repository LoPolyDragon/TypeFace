//
//  CollectionsListView.swift
//  TypeFace
//
//  List view for font collections
//

import SwiftUI

struct CollectionsListView: View {
    let collections: [FontCollection]
    let onDelete: (FontCollection) -> Void

    var body: some View {
        if collections.isEmpty {
            EmptyStateView(
                icon: "square.grid.2x2",
                title: "No Collections",
                message: "Create collections to save font combinations"
            )
        } else {
            List {
                ForEach(collections, id: \.id) { collection in
                    NavigationLink {
                        CollectionDetailView(collection: collection)
                    } label: {
                        CollectionRow(collection: collection)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            onDelete(collection)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

struct CollectionRow: View {
    let collection: FontCollection

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(collection.name)
                    .font(.headline)

                Spacer()

                Text("\(collection.fontNames.count) fonts")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if !collection.notes.isEmpty {
                Text(collection.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Text("Modified \(collection.dateModified.formatted(.relative(presentation: .named)))")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    CollectionsListView(
        collections: [],
        onDelete: { _ in }
    )
}
