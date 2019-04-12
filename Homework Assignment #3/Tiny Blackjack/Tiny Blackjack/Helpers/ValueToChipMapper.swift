import Foundation

class ValueToChipMapper {

    func map(_ value: String) -> Chip {

        var chip: Chip

        switch value {
        case "1":
            chip = Chip.lightRed
        case "5":
            chip = Chip.pink
        case "10":
            chip = Chip.lightBlue
        case "25":
            chip = Chip.purple
        case "50":
            chip = Chip.darkRed
        case "100":
            chip = Chip.darkBlue
        default:
            chip = Chip.unknown
        }

        return chip
    }
}

