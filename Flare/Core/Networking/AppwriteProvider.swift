import Appwrite
import Foundation

final class AppwriteProvider {
    
    static let shared = AppwriteProvider()
    static let endpoint = "http://localhost/v1"
    
    // TODO: Add Project ID from the config
    static let projectId = ""
    
    let client: Client
    let account: Account
    
    private init() {
        self.client = Client()
            .setEndpoint(Self.endpoint)
            .setProject(Self.projectId)
        
        self.account = Account(client)
    }
}
