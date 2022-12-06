import SwiftUI
import Combine

extension RecordExerciseView {
    var ASCMachines: some View {
        VStack {
            Divider()
            AttributeInputTextField(
                attributeTitle: "Weight",
                textSelection: $viewModel.weight,
                receivingFunction: { newValue in
                    var returnString = ""
                    let numFiltered = newValue.filter { "0123456789".contains($0) }
                    let sizeFiltered = numFiltered.prefix(3)
                    if sizeFiltered != newValue {
                        returnString = String(sizeFiltered)
                    }
                    return returnString
                },
                isDisabled: viewModel.fieldsDisabled
            )
            switch workout {
            case ASCMachinesName.rowMachine.rawValue:
                AttributeInputIntPicker(
                    attributeTitle: "Chest Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
                AttributeInputIntPicker(
                    attributeTitle: "Seat Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
            default:
                AttributeInputIntPicker(
                    attributeTitle: "Machine Setting",
                    pickerSelection: $viewModel.machineSetting,
                    pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                    isDisabled: viewModel.fieldsDisabled
                )
            }
            AttributeInputIntPicker(
                attributeTitle: "Sets",
                pickerSelection: $viewModel.sets,
                pickerSelections: viewModel.createIntArr(from: 1, through: 10, by: 1),
                isDisabled: viewModel.fieldsDisabled
            )
            AttributeInputStringPicker(
                attributeTitle: "Reps",
                pickerSelection: $viewModel.reps,
                pickerSelections: viewModel.repOptions,
                isDisabled: viewModel.fieldsDisabled
            )
        }
    }
    
    enum ASCMachinesName: String {
        case bicepCurlStation = "Bicep Curl Station"
        case shoulderPress = "Shoulder Press"
        case bicepAndTricepCableCar = "Bicep and Tricep Cable Car"
        case chestPress = "Chest Press"
        case lateralPullDownMachine = "Lateral Pull-down Machine"
        case butterflyMachine = "Butterfly Machine"
        case inclinePress = "Incline Press"
        case rowMachine = "Row Machine"
        case tricepsPress = "Triceps Press"
    }
}
