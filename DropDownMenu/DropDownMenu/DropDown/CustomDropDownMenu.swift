import SwiftUI


// MARK: - Main View
struct MainView: View {
    @State private var activeDropdown: UUID? = nil
    @State private var activeDropdown1: UUID? = nil
    @State private var buttonFrame: CGRect = .zero
    @State private var buttonFrame1: CGRect = .zero
    @State private var selectedOption: (title: String, subtitle: String, image: String)?
    @State private var selectedOption1: String = "Select an option"

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    CustomDropdown(activeDropdown: $activeDropdown, buttonFrame: $buttonFrame, selectedOption: $selectedOption)
                   
                }
                .padding()
            }

            if activeDropdown != nil {
                DropdownOverlay(activeDropdown: $activeDropdown, buttonFrame: buttonFrame, selectedOption: $selectedOption)
                    .zIndex(1)
            }
           
        }
    }
}


struct CustomDropdown_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


struct DropdownOverlay: View {
    @Binding var activeDropdown: UUID?
    var buttonFrame: CGRect
    @Binding var selectedOption: (title: String, subtitle: String, image: String)?

    let options: [(title: String, subtitle: String, image: String)] = [
        ("Option 1", "This is the first option", "star"),
        ("Option 2", "This is the second option", "heart"),
        ("Option 3", "This is the third option", "bolt")
    ]

    var body: some View {
        VStack(spacing: 5) {
            ForEach(options, id: \..title) { option in
                Button(action: {
                    selectedOption = option
                    activeDropdown = nil
                }) {
                    HStack(spacing: 10) {
                        Image(systemName: option.image)
                            .foregroundColor(.blue)

                        VStack(alignment: .leading) {
                            Text(option.title)
                                .font(.headline)
                                .foregroundColor(.primary)

                            Text(option.subtitle)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.thinMaterial)
                }
            }
        }
        .frame(width: buttonFrame.width)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
        .position(x: buttonFrame.midX, y: selectedOption == nil ? (buttonFrame.maxY + 50) : (buttonFrame.maxY + 50))
    }
}

struct CustomDropdown: View {
    @Binding var activeDropdown: UUID?
    @Binding var buttonFrame: CGRect
    @Binding var selectedOption: (title: String, subtitle: String, image: String)?
    let id = UUID()

    @State private var isDropdownVisible: Bool = false

    var body: some View {
        ZStack(alignment: .topLeading) {
            Button(action: {
                withAnimation {
                    if activeDropdown == id {
                        activeDropdown = nil
                        isDropdownVisible = false
                    } else {
                        activeDropdown = id
                        isDropdownVisible = true
                    }
                }
            }) {
                HStack {
                    if let selectedOption = selectedOption {
                        HStack(spacing: 10) {
                            Image(systemName: selectedOption.image)
                                .foregroundColor(.blue)

                            VStack(alignment: .leading) {
                                Text(selectedOption.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)

                                Text(selectedOption.subtitle)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.thinMaterial)
                    } else {
                        Text("Select a Card")
                    }

                    Spacer()

                    Image(systemName: "chevron.down")
                        .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
                        .foregroundColor(.gray)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedOption != nil ? Color.blue : Color.clear, lineWidth: 2)
                )
                .background(GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.async {
                                self.buttonFrame = geo.frame(in: .global)
                            }
                        }
                        .onChange(of: geo.frame(in: .global)) { _ in
                            DispatchQueue.main.async {
                                self.buttonFrame = geo.frame(in: .global)
                            }
                        }
                })
            }
            
            // ✅ Label exactly on the border
            if let selectedOption = selectedOption, selectedOption.title != "Select a Card" {
                Text("Selected Option")
                    .font(.caption)
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .padding(.horizontal, 5)
                    .offset(x: 15, y: -8) // Adjust position over the border
            }
        }
    }
}
