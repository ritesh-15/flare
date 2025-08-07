import Foundation

final class MobileNumberViewModel: ObservableObject {
 
    static let countries: [CountryModel] = [
        CountryModel(name: "+91", flag: "🇮🇳"),
        CountryModel(name: "+1", flag: "🇺🇸"),
        CountryModel(name: "+21", flag: "🇬🇧"),
        CountryModel(name: "+34", flag: "🇩🇪"),
        CountryModel(name: "+89", flag: "🇯🇵")
    ]
    
    @Published var selectedCountry: CountryModel?
    @Published var mobileNumber: String = ""
    
    init() {
        selectedCountry = Self.countries.first
    }
}
