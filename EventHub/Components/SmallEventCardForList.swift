//
//  SmallEventCardForList.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 02.12.2024.
//

import SwiftUI
import WebKit

struct SmallEventCardForList: View {
    let title: String
    let link: String
    
    @State private var isWebViewPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .airbnbCerealFont(.bold, size: 15)
                    .foregroundStyle(.titleFont)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
             
                BlueButtonWithArrow(
                    text: "READ",
                    action: {
                        isWebViewPresented = true
                    }
                )
                .cornerRadius(30)
            }
            .padding(7)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.appBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .titleFont.opacity(0.1), radius: 8, x: 0, y: 10)
        }
        .sheet(isPresented: $isWebViewPresented) {
            WebView(url: URL(string: link)!)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

#Preview {
    SmallEventCardForList(
        title: "Sample Event",
        link: "https://example.com"
    )
}
