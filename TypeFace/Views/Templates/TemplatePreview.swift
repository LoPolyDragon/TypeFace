//
//  TemplatePreview.swift
//  TypeFace
//
//  Preview rendering for different template scenes
//

import SwiftUI

struct TemplatePreview: View {
    let template: SceneTemplate
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        Group {
            switch template {
            case .titleHeading:
                TitleHeadingTemplate(font: font, text: text, settings: settings)
            case .bodyText:
                BodyTextTemplate(font: font, text: text, settings: settings)
            case .logo:
                LogoTemplate(font: font, text: text, settings: settings)
            case .poster:
                PosterTemplate(font: font, text: text, settings: settings)
            case .socialMedia:
                SocialMediaTemplate(font: font, text: text, settings: settings)
            case .businessCard:
                BusinessCardTemplate(font: font, text: text, settings: settings)
            case .appUI:
                AppUITemplate(font: font, text: text, settings: settings)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 10, y: 5)
    }
}

struct TitleHeadingTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        VStack(spacing: 24) {
            Text(text)
                .applyTypographySettings(settings, fontName: font.fontName)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(40)
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
}

struct BodyTextTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        ScrollView {
            Text(text)
                .applyTypographySettings(settings, fontName: font.fontName)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(32)
        .frame(height: 400)
    }
}

struct LogoTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        VStack {
            Text(text)
                .applyTypographySettings(settings, fontName: font.fontName)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(height: 300)
        .background(
            LinearGradient(
                colors: [Color.accentColor.opacity(0.1), Color.accentColor.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

struct PosterTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        ZStack {
            Color.black

            VStack(spacing: 0) {
                Text(text)
                    .font(.custom(font.fontName, size: settings.fontSize))
                    .foregroundStyle(.white)
                    .kerning(settings.letterSpacing)
                    .lineSpacing(settings.fontSize * (settings.lineHeight - 1))
                    .multilineTextAlignment(.center)
            }
            .padding(40)
        }
        .frame(height: 500)
        .aspectRatio(template.aspectRatio, contentMode: .fit)
    }

    var template: SceneTemplate { .poster }
}

struct SocialMediaTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.accentColor, Color.accentColor.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            VStack {
                Text(text)
                    .font(.custom(font.fontName, size: settings.fontSize))
                    .foregroundStyle(.white)
                    .kerning(settings.letterSpacing)
                    .lineSpacing(settings.fontSize * (settings.lineHeight - 1))
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
            }
            .padding(32)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .cornerRadius(12)
    }
}

struct BusinessCardTemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        ZStack {
            Color.white

            VStack(alignment: .leading, spacing: 8) {
                Text(text)
                    .applyTypographySettings(settings, fontName: font.fontName)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                HStack {
                    Spacer()
                    Text("TypeFace")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(24)
        }
        .frame(height: 220)
        .aspectRatio(1.75, contentMode: .fit)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct AppUITemplate: View {
    let font: FontInfo
    let text: String
    let settings: TypographySettings

    var body: some View {
        VStack(spacing: 0) {
            // Mock Navigation Bar
            HStack {
                Image(systemName: "line.3.horizontal")
                    .font(.title3)
                Spacer()
                Image(systemName: "person.circle")
                    .font(.title3)
            }
            .padding()
            .background(Color(white: 0.98))

            VStack(alignment: .leading, spacing: 16) {
                Text(text)
                    .applyTypographySettings(settings, fontName: font.fontName)

                // Mock Content
                ForEach(0..<3) { _ in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1))
                        .frame(height: 60)
                }

                Spacer()
            }
            .padding()
        }
        .frame(height: 400)
        .background(Color.white)
    }
}

#Preview {
    TemplatePreview(
        template: .titleHeading,
        font: FontInfo(familyName: "San Francisco", fontName: "SFProText-Bold"),
        text: "The Quick Brown Fox",
        settings: .default
    )
    .padding()
}
