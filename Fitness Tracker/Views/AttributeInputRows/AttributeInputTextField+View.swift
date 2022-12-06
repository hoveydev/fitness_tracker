import Combine
import SwiftUI

struct AttributeInputTextField: View {
    var attributeTitle: String
    
    @Binding var textSelection: String
    var trailingText: String?
    
    var isDisabled: Bool
    
    var body: some View {
        VStack {
            HStack {
                Section(header: Text(attributeTitle).frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField(attributeTitle, text: $textSelection)
                        .disabled(isDisabled)
                        .keyboardType(.numberPad)
                    Text(trailingText ?? "")
                }
            }
            .padding(.horizontal)
            Divider()
        }
    }
}

struct AttributeInputTextField_Previews: PreviewProvider {
    static var previews: some View {
        AttributeInputTextField(
            attributeTitle: "Text Field Attribute",
            textSelection: .constant("Text"),
            trailingText: "lbs",
            isDisabled: false
        )
    }
}
