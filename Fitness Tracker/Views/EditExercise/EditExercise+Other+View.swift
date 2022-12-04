import Combine
import SwiftUI

extension EditExerciseView {
    var other: some View {
        VStack {
            Divider()
            switch workout.name {
            case othersName.freeweights.rawValue:
                HStack {
                    Section(header: Text("Exercise/Muscles").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Exercise/Muscles", text: $viewModel.freeWeightExercise)
                            .frame(width: 140)
                    }
                    .padding(.horizontal)
                }
                Divider()
                HStack {
                    Section(header: Text("Weight").frame(maxWidth: .infinity, alignment: .leading)) {
                        TextField("Weight", text: $viewModel.weight)
                            .keyboardType(.numberPad)
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
                }
                Divider()
                HStack {
                    Section(header: Text("Sets").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Sets", selection: $viewModel.sets) {
                            ForEach(viewModel.oneThroughTen, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
                HStack {
                    Section(header: Text("Reps").frame(maxWidth: .infinity, alignment: .leading)) {
                        Picker("Reps", selection: $viewModel.reps) {
                            ForEach(viewModel.repOptions, id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, -3)
                }
                Divider()
            default:
                EmptyView()
            }
        }
    }
    
    enum othersName: String {
        case freeweights = "Freeweights"
        case walking = "Walking"
        case running = "Running"
        case hiking = "Hiking"
        case yoga = "Yoga"
        case stretching = "Stretching"
    }
}
