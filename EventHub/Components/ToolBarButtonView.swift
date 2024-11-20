struct ToolBarButtonView: View {
    let action: ToolBarAction
    
    var body: some View {
        Button(action: action.action) {
            ZStack {
                if action.hasBackground {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.3))
                        .frame(width: 36, height: 36)
                        .background(.ultraThinMaterial)
                }
                Image(action.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(action.foregroundStyle)
            }
        }
    }
}