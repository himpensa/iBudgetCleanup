import SwiftUI
import SwiftData

@Model class Category: Codable {
    var category_id: UUID
    var category_name: String
    var category_icon: String
    var parentID: Int?

    init(category_id: UUID = UUID(), category_name: String = "", category_icon: String = "questionmark.circle", parentID: Int? = nil) {
        self.category_id = category_id
        self.category_name = category_name
        self.category_icon = category_icon
        self.parentID = parentID
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_id = try values.decode(UUID.self, forKey: .category_id)
        category_name = try values.decode(String.self, forKey: .category_name)
        category_icon = try values.decode(String.self, forKey: .category_icon)
        parentID = try values.decodeIfPresent(Int.self, forKey: .parentID)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(category_id, forKey: .category_id)
        try container.encode(category_name, forKey: .category_name)
        try container.encode(category_icon, forKey: .category_icon)
        try container.encodeIfPresent(parentID, forKey: .parentID)
    }

    enum CodingKeys: String, CodingKey {
        case category_id
        case category_name
        case category_icon
        case parentID
    }
}
