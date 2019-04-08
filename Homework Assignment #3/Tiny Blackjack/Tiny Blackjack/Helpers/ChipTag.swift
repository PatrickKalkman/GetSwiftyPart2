import Foundation

class ChipTag {
    
    func static create(_ chip: Chip) -> Int {
        return Int(10000 + chip.rawValue)
    }

}