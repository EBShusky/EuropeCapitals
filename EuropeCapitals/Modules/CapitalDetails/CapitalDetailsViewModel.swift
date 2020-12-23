import Foundation

protocol CapitalDetailsViewModelProtocol {
    func handleEvent(event: CapitalDetailsEvent)

    var isLoading: Binder<Bool> { get }
    var showError: Binder<Bool> { get }
    var details: Binder<CapitalDetailsViewData> { get }
    var isFavourite: Binder<Bool> { get }
}

class CapitalDetailsViewModel: CapitalDetailsViewModelProtocol {

    private let capital: Capital
    private let coordinator: CapitalDetailsCoordinatorProtocol
    private let capitalDetailsRepository: CapitalDetailsRepositoryProtocol
    private let favouritesRepository: FavouriteCapitalsRepositoryProtocol
    private var viewers: [CapitalViewer] = []

    var isLoading: Binder<Bool> = Binder(false)
    var showError: Binder<Bool> = Binder(false)
    var details: Binder<CapitalDetailsViewData> = Binder(CapitalDetailsViewData())
    var isFavourite: Binder<Bool> = Binder<Bool>(false)

    init(capital: Capital,
         coordinator: CapitalDetailsCoordinatorProtocol,
         capitalDetailsRepository: CapitalDetailsRepositoryProtocol,
         favouritesRepository: FavouriteCapitalsRepositoryProtocol) {
        self.capital = capital
        self.coordinator = coordinator
        self.capitalDetailsRepository = capitalDetailsRepository
        self.favouritesRepository = favouritesRepository
    }

    func handleEvent(event: CapitalDetailsEvent) {
        switch event {
        case .fetch:
            handleFetch()
        case .viewersTapped:
            handleViewersTapped()
        case .favouriteStatusChanged:
            handleFavouriteStatusChanged()
        }
    }

    private func handleFetch() {
        isLoading.updateValue(true)
        showError.updateValue(false)
        isFavourite.updateValue(favouritesRepository.isFavourite(capitalId: capital.id))

        getDetailsAndViewers { [weak self] details, viewers, error in
            self?.isLoading.updateValue(false)

            if error != nil {
                self?.showError.updateValue(true)
            }

            if let capital = self?.capital,
               let details = details,
               let viewers = viewers {
                self?.details.updateValue(CapitalDetailsViewData(capital: capital,
                                                                 capitalDetails: details,
                                                                 capitalViewers: viewers))
                self?.viewers = viewers
            }
        }
    }

    private func handleViewersTapped() {
        coordinator.showCapitalViewers(viewers: viewers)
    }

    private func handleFavouriteStatusChanged() {
        if favouritesRepository.isFavourite(capitalId: capital.id) {
            favouritesRepository.removeFromFavourites(capitalId: capital.id)
        } else {
            favouritesRepository.addToFavourites(capitalId: capital.id)
        }
        isFavourite.updateValue(favouritesRepository.isFavourite(capitalId: capital.id))
    }

    private func getDetailsAndViewers(callback: @escaping (CapitalDetails?, [CapitalViewer]?, Error?) -> ()) {
        let group = DispatchGroup()

        var finalDetails: CapitalDetails?
        var finalViewers: [CapitalViewer]?

        group.enter()
        capitalDetailsRepository.getDetails(capitalId: capital.id) { details, _ in
            finalDetails = details
            group.leave()
        }

        group.enter()
        capitalDetailsRepository.getViewers(capitalId: capital.id) { viewers, _ in
            finalViewers = viewers
            group.leave()
        }

        group.notify(queue: .main) {
            guard let finalDetails = finalDetails,
                  let finalViewers = finalViewers else {
                callback(nil, nil, ApiClientError.error)
                return
            }

            callback(finalDetails, finalViewers, nil)
        }
    }
}
