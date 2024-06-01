import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WebViewModel()
    @State private var inputURL: String = ""
    @State private var showMenu: Bool = false // State to control the visibility of the menu
    
    @AppStorage("isDarkMode") var isDarkMode = false // App storage for dark mode preference
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // WebView with hidden navigation bar
            NavigationView {
                ZStack {
                    // Colored background for WebView
                    Rectangle()
                        .fill(isDarkMode ? Color.black : Color.white) // Change color based on dark mode
                        .edgesIgnoringSafeArea(.all)
                    // WebView
                    WebView(urlString: viewModel.urlString)
                        .navigationBarHidden(true) // Hide the navigation bar
                        .navigationBarTitle("") // Set an empty title
                        .navigationBarBackButtonHidden(true) // Hide back button if necessary
                        .padding(.top, 37) // Adjust the size of notch space
                        .padding(.bottom, 20) // Adjust the size of bottom space
                        .edgesIgnoringSafeArea(.top) // Ignore safe area for the top edge
                        .edgesIgnoringSafeArea(.bottom) // Ignore safe area for the bottom edge
                        .statusBar(hidden: true) // Hide the status bar
                        .onAppear {
                            viewModel.loadURL()
                        }
                    // Side menu
                    if showMenu {
                        SideMenuView(inputURL: $inputURL, viewModel: viewModel, showMenu: $showMenu)
                            .transition(.move(edge: .leading))
                    }
                }
            }
            
            // Menu button
            Button(action: {
                showMenu.toggle()
            }) {
                Image(systemName: "line.horizontal.3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(isDarkMode ? .white : .primary) // Change color based on dark mode
                    .padding()
            }
            .padding(.top, 20) // Adjust the padding for the notch space
            .padding(.leading, 10) // Add padding to avoid overlap with side menu
            .zIndex(1) // Ensure the button appears above other views
        }
        .edgesIgnoringSafeArea(.all) // Ignore safe area for all edges
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Handle when the app enters foreground
            viewModel.loadURL()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
