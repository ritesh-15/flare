import SwiftUI

struct FiltersScreen: View {
    
    @State var gender: String = ""
    @State var location: String = ""
    @State private var range: Double = 0
    
    let genders = ["Male", "Female", "Other"]
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Spacer()
                
                Text("Filters")
                    .font(.title3)
                    .bold()
                
                Spacer()
                
                FButton(action: {
                    
                }, buttonType: .link, text: "Clear")
            }
            
            Form {
                Section("Interested In") {
                    Picker("Selected Gender", selection: $gender) {
                        ForEach(genders, id: \.self) { gender in
                            Text(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                }
               
                Section("Location") {
                    TextField("Enter location", text: $location)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .tint(.brandPrimary)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                }
                
                Section("How far are they ?") {
                    VStack {
                        HStack(alignment: .center) {
                            Text("Distance")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            Text("40 km")
                                .font(.caption)
                        }
                        
                        Slider(value: $range, in: 0...100)
                            .tint(.brandPrimary)
                    }
                }
                
                Section("How old are they ?") {
                    VStack {
                        HStack(alignment: .center) {
                            Text("Age")
                                .font(.title3)
                                .bold()
                            
                            Spacer()
                            
                            Text("20 - 28")
                                .font(.caption)
                        }
                        
                        Slider(value: $range, in: 0...100)
                            .tint(.brandPrimary)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            
            FButton(action: {
                
            }, text: "Save")
        }.padding()
    }
}

#Preview {
    FiltersScreen()
}
