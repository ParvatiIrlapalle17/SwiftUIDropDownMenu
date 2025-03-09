//import SwiftUI
//
//struct CustomDropdown: View {
//    @Binding var activeDropdown: UUID?
//    @Binding var selectedOption: String
//    let id: UUID
//    let icon: String?
//    let subtitle: String?
//
//    @State private var isDropdownVisible: Bool = false
//    @State private var buttonFrame: CGRect = .zero
//
//    var body: some View {
//        ZStack(alignment: .topLeading) {
//            Button(action: {
//                withAnimation {
//                    if activeDropdown == id {
//                        activeDropdown = nil
//                        isDropdownVisible = false
//                    } else {
//                        activeDropdown = id
//                        isDropdownVisible = true
//                    }
//                }
//            }) {
//                VStack(alignment: .leading, spacing: 2) {
//                    HStack {
//                        if let icon = icon {
//                            Image(systemName: icon)
//                                .foregroundColor(.blue)
//                        }
//                        
//                        Text(selectedOption)
//                            .foregroundColor(.primary)
//                        
//                        Spacer()
//                        
//                        Image(systemName: "chevron.down")
//                            .rotationEffect(.degrees(isDropdownVisible ? 180 : 0))
//                            .foregroundColor(.gray)
//                    }
//                    
//                    if let subtitle = subtitle {
//                        Text(subtitle)
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                    }
//                }
//                .padding()
//                .background(.ultraThinMaterial)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .shadow(radius: 2)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(selectedOption == "Select an option" ? Color.clear : Color.blue, lineWidth: 2)
//                )
//                .background(GeometryReader { geo in
//                    Color.clear
//                        .onAppear {
//                            DispatchQueue.main.async {
//                                self.buttonFrame = geo.frame(in: .global)
//                            }
//                        }
//                })
//            }
//            .overlay(
//                Text(selectedOption == "Select an option" ? "" : "Selected Option")
//                    .font(.caption)
//                    .foregroundColor(.blue)
//                    .background(Color.white)
//                    .padding(.horizontal, 5)
//                    .offset(y: -12),
//                alignment: .topLeading
//            )
//        }
//    }
//}
//
//// MARK: - Main View
//struct MainView: View {
//    @State private var activeDropdown: UUID? = nil
//    @State private var selectedOption1: String = "Select an option"
//    @State private var selectedOption2: String = "Select an option"
//    
//    private let firstDropdownID = UUID()
//    private let secondDropdownID = UUID()
//
//    var body: some View {
//        ZStack {
//            ScrollView {
//                VStack(spacing: 20) {
//                    CustomDropdown(activeDropdown: $activeDropdown, selectedOption: $selectedOption1, id: firstDropdownID, icon: "star.fill", subtitle: "Choose your favorite star")
//                    CustomDropdown(activeDropdown: $activeDropdown, selectedOption: $selectedOption2, id: secondDropdownID, icon: nil, subtitle: "Pick an option")
//                }
//                .padding()
//            }
//
//            if let dropdownID = activeDropdown {
//                DropdownOverlay(activeDropdown: $activeDropdown, selectedOption: dropdownID == firstDropdownID ? $selectedOption1 : $selectedOption2, subtitle: "Select an option from the list", icon: "list.bullet")
//                    .zIndex(1)
//            }
//        }
//    }
//}
//
//// MARK: - Dropdown Overlay
//struct DropdownOverlay: View {
//    @Binding var activeDropdown: UUID?
//    @Binding var selectedOption: String
//    let subtitle: String?
//    let icon: String?
//
//    let options = ["Option 1", "Option 2", "Option 3"]
//
//    var body: some View {
//        VStack(spacing: 16) {
//           
//            ForEach(options, id: \ .self) { option in
//                Button(action: {
//                    selectedOption = option
//                    activeDropdown = nil
//                }) {
//                    HStack(alignment: .center, spacing: 0) {
//                    if let icon = icon {
//                        Image(systemName: icon)
//                            .foregroundColor(.blue)
//                    }
//                        Spacer()
//                        VStack(alignment: .leading) {
//                        
//                        if let subtitle = subtitle {
//                            Text(subtitle)
//                                .font(.caption)
//                                .foregroundColor(.gray)
//                        }
//                        
//                        Text(option)
//                            .foregroundColor(.primary)
//                    }
//                }
//                    .padding()
//                }
//            }
//        }
//        .frame(maxWidth: 200)
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 10))
//        .shadow(radius: 2)
//        .offset(y: 50)
//    }
//}
//
//struct CustomDropdown_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
