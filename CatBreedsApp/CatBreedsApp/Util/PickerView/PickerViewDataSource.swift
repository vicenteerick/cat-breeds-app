import UIKit

protocol PickerItem {
    var name: String { get }
}

final class PickerViewDataSource<T: PickerItem>: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    private let data: [T]
    @Published private(set) var selectedItem: T?

    init(data: [T]) {
        self.data = data
        selectedItem = data.first
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        data.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        data[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedItem = data[row]
    }
}
