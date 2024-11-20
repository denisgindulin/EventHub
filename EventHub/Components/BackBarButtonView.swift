struct BackBarButtonView: View {
    @Environment(\.dismiss) var dismiss

    let foregroundStyle: Color = .black
    
    var body: some View {
        Button(action: { dismiss() } ) {
            Image(systemName: ToolBarButtonType.back.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundStyle(foregroundStyle)
        }
    }
}