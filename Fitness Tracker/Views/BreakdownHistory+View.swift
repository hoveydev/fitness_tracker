import Charts
import SwiftUI

struct BreakdownHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    func reRecordWorkoutWithNoWeekOf(with data: FetchedResults<Workout>) -> (() -> Void)? {
        for workout in data {
            guard workout.dateRange != nil, workout.dateCompleted != nil else { return nil }
            let newDateRange = viewModel.findDateRangeForDate(date: workout.dateCompleted ?? Date.now)
            workout.dateRange = newDateRange
            try? moc.save()
        }
        return nil
    }
    
    var body: some View {
        if viewModel.getDateRange(with: workouts).isEmpty {
            Text("Sorry, there is no data to display.")
        } else {
            List(viewModel.getDateRange(with: workouts), children: \.graphs) { week in
                    HStack {
                        if week.dateRange != nil {
                            Text(week.dateRange ?? "test")
                        } else {
                            Chart {
                                BarMark (
                                    x: .value("Day", "Mon"),
                                    y: .value("Total Minutes", week.minutesPerDay?[0].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Tue"),
                                    y: .value("Total Minutes", week.minutesPerDay?[1].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Wed"),
                                    y: .value("Total Minutes", week.minutesPerDay?[2].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Thu"),
                                    y: .value("Total Minutes", week.minutesPerDay?[3].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Fri"),
                                    y: .value("Total Minutes", week.minutesPerDay?[4].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Sat"),
                                    y: .value("Total Minutes", week.minutesPerDay?[5].time ?? 0.0)
                                )
                                BarMark (
                                    x: .value("Day", "Sun"),
                                    y: .value("Total Minutes", week.minutesPerDay?[6].time ?? 0.0)
                                )
                            }
                            .frame(height: 250)
                        }
                    }
                    // should check if any time exists in the week
                    // if not, do not display week at all
                }
            .onAppear(perform: reRecordWorkoutWithNoWeekOf(with: workouts))
            }
        }
    }


struct BreakdownHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BreakdownHistoryView()
    }
}
