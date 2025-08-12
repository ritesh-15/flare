import Appwrite
import Foundation

final class AppwriteProvider {
    
    static let shared = AppwriteProvider()
    static let endpoint = "http://localhost/v1"
    
    // TODO: Add Project ID from the config
    static let projectId = "689973be001b6ef08c25"
    
    let client: Client
    let account: Account
    let database: Databases
    let storage: Storage
    
    private init() {
        self.client = Client()
            .setEndpoint(Self.endpoint)
            .setProject(Self.projectId)
        
        self.account = Account(client)
        self.database = Databases(client)
        self.storage = Storage(client)
    }
}
