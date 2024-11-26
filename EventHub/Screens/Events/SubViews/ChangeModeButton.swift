//
//  ChangeModeButtonsView.swift
//  EventHub
//
//  Created by Келлер Дмитрий on 26.11.2024.
//


import SwiftUI

struct ChangeModeButton: View {
    @Binding var selectedMode: EventsMode
    
    enum Drawing {
        static let padding: CGFloat = 5
        static let frameWidth: CGFloat = 319
        static let buttonPadding: CGFloat = 8
        static let shadowColor: Color = .gray
        static let shadowOpacity: Double = 0.2
        static let shadowRadius: CGFloat = 5
    }
    
    var body: some View {
        HStack {
            ForEach(EventsMode.allCases, id: \.self) { mode in
                modeButton(for: mode)
            }
            .padding(Drawing.padding)
        }
        .frame(width: Drawing.frameWidth)
        .background(Color.fieldGray.opacity(Drawing.shadowOpacity))
        .clipShape(Capsule())
    }

    private func modeButton(for mode: EventsMode) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                           selectedMode = mode
                       }
        } label: {
            Text(mode.title)
                .padding(.vertical, Drawing.buttonPadding)
                .frame(maxWidth: .infinity)
                .background(selectedMode == mode ? Color.white : Color.clear)
                .foregroundStyle(
                    selectedMode == mode ? .appBlue : .appDarkGray
                )
                .clipShape(Capsule())
        }
        .shadow(
            color: Drawing.shadowColor.opacity(selectedMode == mode ? Drawing.shadowOpacity : 0),
            radius: selectedMode == mode ? Drawing.shadowRadius : 0
        )

    }
}



#Preview {
    ChangeModeButton(selectedMode: .constant(.upcoming))
}
