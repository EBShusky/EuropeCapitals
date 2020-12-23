import Foundation

protocol CapitalListViewModelProtocol {
    func handleEvent(event: CapitalListEvent)

    var isLoading: Binder<Bool> { get }
    var showError: Binder<Bool> { get }
    var dataSource: Binder<[CapitalListCellViewData]> { get }
}

class CapitalListViewModel: CapitalListViewModelProtocol {

    private let coordinator: CapitalListCoordinatorProtocol
    private let filteredCapitalRepository: FilteredCapitalListRepositoryProtocol
    private var showOnlyFavouritesSelected: Bool = false

    var isLoading: Binder<Bool> = Binder(false)
    var showError: Binder<Bool> = Binder(false)
    var dataSource: Binder<[CapitalListCellViewData]> = Binder([])

    init(coordinator: CapitalListCoordinatorProtocol,
         filteredCapitalRepository: FilteredCapitalListRepositoryProtocol) {
        self.coordinator = coordinator
        self.filteredCapitalRepository = filteredCapitalRepository
    }

    func handleEvent(event: CapitalListEvent) {
        switch event {
        case .fetch:
            handleFetch()
        case .capitalPicked(let viewData):
            handleCapitalPicked(capital: viewData.rawData)
        case .showFavouritesSelected(let selected):
            handleFavouritesSelected(selected: selected)
        }
    }

    private func handleFetch() {
        isLoading.updateValue(true)
        showError.updateValue(false)

        filteredCapitalRepository.getList(showOnlyFavourites: showOnlyFavouritesSelected,
                                          callback: { [weak self] (capitals, error) in
            self?.isLoading.updateValue(false)

            if error != nil {
                self?.showError.updateValue(true)
            }

            if let capitals = capitals {
                self?.dataSource.updateValue(capitals.map { CapitalListCellViewData(capital: $0) })
            } else {
                self?.dataSource.updateValue([])
            }
        })
    }

    private func handleCapitalPicked(capital: Capital) {
        coordinator.showCapitalDetails(capital: capital)
    }

    private func handleFavouritesSelected(selected: Bool) {
        showOnlyFavouritesSelected = selected
        handleFetch()
    }
}
