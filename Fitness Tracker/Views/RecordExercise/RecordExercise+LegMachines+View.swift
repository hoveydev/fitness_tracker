import SwiftUI
import Combine

extension RecordExerciseView {
    var legMachines: some View {
        VStack {
            Divider()
            HStack {
                Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("Weight", text: $viewModel.weight)
                        .frame(width: 35)
                        .fixedSize()
                        .keyboardType(.numberPad)
                        .disabled(viewModel.fieldsDisabled)
                        .onReceive(Just(viewModel.weight)) { newValue in
                            let numFiltered = newValue.filter { "0123456789".contains($0) }
                            let sizeFiltered = numFiltered.prefix(3)
                            if sizeFiltered != newValue {
                                self.viewModel.weight = String(sizeFiltered)
                            }
                        }
                    Text("lbs")
                }
                .padding(.horizontal)
                .padding(.trailing)
            }
            Divider()
            switch workout {
            case legMachinesName.seatedLegPress.rawValue:
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.createIntArr(from: 1, through: 15, by: 1), id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            case legMachinesName.calfExtension.rawValue:
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.createIntArr(from: 1, through: 5, by: 1), id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            default:
                HStack {
                    Section(header: Text("Machine Setting").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Machine Setting", selection: $viewModel.machineSetting) {
                            ForEach(viewModel.createIntArr(from: 1, through: 10, by: 1), id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(viewModel.fieldsDisabled)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            }
            HStack {
                Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Sets", selection: $viewModel.sets) {
                        ForEach(viewModel.createIntArr(from: 1, through: 10, by: 1), id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                    .disabled(viewModel.fieldsDisabled)
                }
                .padding(.horizontal)
                .padding(.vertical, -3)
            }
            Divider()
            HStack {
                Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                    Picker("Reps", selection: $viewModel.reps) {
                        ForEach(viewModel.repOptions, id: \.self) { number in
                            Text(number)
                        }
                    }
                    .disabled(viewModel.fieldsDisabled)
                }
                .padding(.horizontal)
                .padding(.vertical, -3)
            }
            Divider()
        }
    }
    
    enum legMachinesName: String {
        case seatedLegPress = "Seated Leg Press"
        case angledLegCurlMachine = "Angled Leg Curl Machine"
        case legExtensionMachine = "Leg Extension Machine"
        case sledPush = "Sled Push"
        case calfExtension = "Calf Extension"
    }
}
