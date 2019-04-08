import Foundation

class ValueToChipMapper {
    
    func map(_ value: String) -> Chip {
        
        var chip: Chip

        switch value {
        case "1":
            chip = Chip.LightRed
        case "5":
            chip = Chip.Pink
        case "10":
            chip = Chip.LightBlue
        case "25":
            chip = Chip.Purple
        case "50":
            chip = Chip.DarkRed
        case "100":
            chip = Chip.DarkBlue
        default:
            chip = Chip.Unknown
        }

        return chip
    }
}
    