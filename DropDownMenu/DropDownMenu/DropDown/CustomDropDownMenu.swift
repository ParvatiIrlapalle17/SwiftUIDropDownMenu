import SwiftUI

struct CustomDropdown: View {
    @Binding var activeDropdown: UUID?
    @Binding var buttonFrame: CGRect
    @Binding var selectedOption: String
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
                    Text(selectedOption)
                        .foregroundColor(.primary)

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
                        .stroke(selectedOption == "Select an option" ? Color.clear : Color.blue, lineWidth: 2)
                )
                .background(GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            DispatchQueue.main.async {
                                self.buttonFrame = geo.frame(in: .global)
                            }
                        }
                })
            }
            
            // ✅ Label exactly on the border
            if selectedOption != "Select an option" {
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

// MARK: - Main View
struct MainView: View {
    @State private var activeDropdown: UUID? = nil
    @State private var activeDropdown1: UUID? = nil
    @State private var buttonFrame: CGRect = .zero
    @State private var buttonFrame1: CGRect = .zero
    @State private var selectedOption: String = "Select an option"
    @State private var selectedOption1: String = "Select an option"

    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 20) {
                    CustomDropdown(activeDropdown: $activeDropdown, buttonFrame: $buttonFrame, selectedOption: $selectedOption)
                    CustomDropdown(activeDropdown: $activeDropdown1, buttonFrame: $buttonFrame1, selectedOption: $selectedOption1)
                }
                .padding()
            }

            if activeDropdown != nil {
                DropdownOverlay(activeDropdown: $activeDropdown, buttonFrame: buttonFrame, selectedOption: $selectedOption)
                    .zIndex(1)
            }
            if activeDropdown1 != nil {
                DropdownOverlay(activeDropdown: $activeDropdown1, buttonFrame: buttonFrame1, selectedOption: $selectedOption1)
                    .zIndex(1)
            }
        }
    }
}

// MARK: - Dropdown Overlay
struct DropdownOverlay: View {
    @Binding var activeDropdown: UUID?
    var buttonFrame: CGRect
    @Binding var selectedOption: String

    let options = ["Option 1", "Option 2", "Option 3"]

    var body: some View {
        VStack(spacing: 5) {
            ForEach(options, id: \.self) { option in
                Button(action: {
                    selectedOption = option
                    activeDropdown = nil
                }) {
                    Text(option)
                        .foregroundColor(.primary)
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
        .position(x: buttonFrame.midX, y: buttonFrame.maxY + 40)
    }
}

struct CustomDropdown_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

