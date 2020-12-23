import Foundation

protocol CapitalViewersViewModelProtocol {
    func handleEvent(event: CapitalViewersEvent)

    var dataSource: Binder<[CapitalViewersCellViewData]> { get }
}

class CapitalViewersViewModel: CapitalViewersViewModelProtocol {

    private let viewers: [CapitalViewer]

    var dataSource: Binder<[CapitalViewersCellViewData]> = Binder([])

    init(viewers: [CapitalViewer]) {
        self.viewers = viewers
    }

    func handleEvent(event: CapitalViewersEvent) {
        switch event {
        case .fetch:
            handleFetch()
        }
    }

    private func handleFetch() {
        dataSource.updateValue(viewers.map{ CapitalViewersCellViewData(viewer: $0) })
    }
}
