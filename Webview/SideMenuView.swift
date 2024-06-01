import SwiftUI

struct SideMenuView: View {
    @Binding var inputURL: String
    @ObservedObject var viewModel: WebViewModel
    @Environment(\.presentationMode) var presentationMode
    @Binding var showMenu: Bool // Binding to control the visibility of the side menu
    
    @AppStorage("isDarkMode") var isDarkMode = false // App storage for dark mode preference
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 20) {
                // Header to prevent overlapping with notch
                Color.clear
                    .frame(height: geometry.safeAreaInsets.top) // Adjust for safe area insets
                
                Spacer() // Push content to the bottom
                
                Text("Enter URL")
                    .font(.headline)
                    .foregroundColor(.primary) // Use primary color for text
                
                TextField("Enter URL", text: $inputURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .background(Color(UIColor.systemBackground)) // Use system background color
                    .foregroundColor(.primary) // Use primary color for text
                    .onTapGesture {
                        // Dismiss keyboard if currently active
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                
                Button("Save URL") {
                    let formattedURL = viewModel.formatURL(inputURL)
                    guard let url = URL(string: formattedURL), UIApplication.shared.canOpenURL(url) else {
                        print("Invalid URL")
                        return
                    }
                    viewModel.saveURL(url: formattedURL)
                    viewModel.urlString = formattedURL
                    showMenu.toggle() // Close the side menu after saving URL
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemBackground)) // Use system background color
                .foregroundColor(.primary) // Use primary color for text
                
                // Dark mode toggle button
                Button(action: {
                    isDarkMode.toggle()
                }) {
                    Text(isDarkMode ? "Light Mode" : "Dark Mode")
                        .foregroundColor(isDarkMode ? .black : .black)
                        .padding()
                        .background(isDarkMode ? Color.white : Color.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20) // Add bottom padding
                

            // GitHub URL
            Link("GitHub: moccafloat", destination: URL(string: "https://github.com/moccafloat")!)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.horizontal)

            // X URL
            Link("X: moccaf1oat", destination: URL(string: "https://x.com/moccaf1oat")!)
                .font(.footnote)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Spacer()
            }
            .padding()
            .frame(width: 250) // Set frame width
            .background(isDarkMode ? Color.black : Color.blue) // Use dark mode or light mode color
            .edgesIgnoringSafeArea(.vertical) // Ignore safe area for vertical edges
            .alignmentGuide(.leading) { _ in geometry.size.width / 2 } // Center the view horizontally
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(inputURL: .constant(""), viewModel: WebViewModel(), showMenu: .constant(true))
    }
}
