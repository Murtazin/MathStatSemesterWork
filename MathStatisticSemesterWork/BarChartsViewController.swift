import UIKit
import Charts

class BarChartsViewController: UIViewController {
    
    var intervalValues: [Int] = []
    var frequencies: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        intervalValues = DataManager.shared.getValuesForIntervals()
        frequencies = DataManager.shared.getFrequency()
        createChart()
    }
    
    private func createChart() {
        // Create bar chart
        let barChart = BarChartView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width))
        
        // Supply data
        var entries = [BarChartDataEntry]()
        
        for index in 0..<DataManager.shared.getCountOfIntervals() {
            for elem in stride(from: intervalValues[index], to: intervalValues[index+1], by: 1) {
                entries.append(BarChartDataEntry(x: Double(elem), y: Double(frequencies[index])))
            }
        }
        let set = BarChartDataSet(entries: entries, label: "Cost")
        set.colors = ChartColorTemplates.pastel()
        let data = BarChartData(dataSet: set)
        barChart.data = data
        view.addSubview(barChart)
        barChart.center = view.center
    }
}
