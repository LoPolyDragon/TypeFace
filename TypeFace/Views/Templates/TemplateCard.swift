//
//  TemplateCard.swift
//  TypeFace
//
//  Template selection card component
//

import SwiftUI

struct TemplateCard: View {
    let template: SceneTemplate
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: template.icon)
                    .font(.title2)
                    .foregroundStyle(isSelected ? .white : .primary)

                Text(template.rawValue)
                    .font(.caption)
                    .foregroundStyle(isSelected ? .white : .primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(width: 100, height: 100)
            .background(isSelected ? Color.accentColor : Color.cardBackground)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        TemplateCard(template: .titleHeading, isSelected: true, action: {})
        TemplateCard(template: .bodyText, isSelected: false, action: {})
    }
    .padding()
}
