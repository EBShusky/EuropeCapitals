import Foundation

class Binder<T> {
    private(set) var value: T
    private var binderList: [(T) -> ()] = []

    init(_ initialValue: T) {
        self.value = initialValue
    }

    func updateValue(_ value: T) {
        self.value = value

        DispatchQueue.main.async {
            self.binderList.forEach {
                $0(value)
            }
        }
    }

    func bind(_ binder: @escaping (T) -> ()) {
        binderList.append(binder)
    }

    deinit {
        binderList.removeAll()
    }
}
