import Foundation

enum CapitalListEvent {
    case fetch
    case capitalPicked(viewData: CapitalListCellViewData)
    case showFavouritesSelected(selected: Bool)
}
