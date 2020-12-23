import Foundation

struct CapitalViewersCellViewData {

    let name: String

    init(viewer: CapitalViewer) {
        self.name = viewer.name
    }
}
