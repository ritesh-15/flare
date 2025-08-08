import SwiftUI

struct ProfileDetailsScreen: View {
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var birthDate: Date = Date()
    @State private var shouldShowChooseBirthDateSheet: Bool = false
    
    var body: some View {
        WrapperContainer(shouldShowTopNavBar: true) {
            VStack(alignment: .leading, spacing: 40) {
                VStack(alignment: .leading) {
                    Text("Profile Details")
                        .font(.system(size: 34, weight: .bold))
                    
                    Text("Please choose your best pictures and fill up your profile details")
                }
                
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 12) {
                    ForEach(1..<7) {_ in
                        HStack {
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .padding(.horizontal, 12)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(.gray.opacity(0.15), lineWidth: 1)
                        }
                    }
                }
                
                VStack(spacing: 12) {
                    TextField("First Name", text: $firstName)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .tint(.brandPrimary)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                    
                    TextField("Last Name", text: $lastName)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)
                        .tint(.brandPrimary)
                        .padding()
                        .overlay {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.15), lineWidth: 1)
                        }
                    
                    Button {
                        shouldShowChooseBirthDateSheet.toggle()
                    } label: {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tint(.brandPrimary)
                            .foregroundStyle(.brandPrimary)
                            .frame(width: 24, height: 24)
                        
                        Text("Choose birth date")
                            .tint(.brandPrimary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.brandPrimary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                }

                FButton(action: {
                    
                }, text: "Continue")
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $shouldShowChooseBirthDateSheet) {
            VStack(alignment: .leading) {
                DatePicker("Choose birthdate", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .pickerStyle(.inline)
                    .tint(.brandPrimary)
                
                FButton(action: {
                    shouldShowChooseBirthDateSheet.toggle()
                }, text: "Save")
            }
            .padding(.horizontal, 40)
            .presentationDetents([.medium])
        }
    }
}

#Preview {
    ProfileDetailsScreen()
}
