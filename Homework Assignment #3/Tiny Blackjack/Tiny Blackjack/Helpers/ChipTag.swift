import Foundation

class ChipTag {
    
    static func create(_ chip: Chip) -> Int {
        return Int(10000 + chip.rawValue)
    }

}
