import Foundation

class DataManager {
    
    // MARK: - Properties
    
    static let shared = DataManager()
    
    var csvData: [String] = []
    var arrayOfNumbers: [Int] = []
    var countOfNumbersInArray: Int = 0
    var countOfIntervals: Int = 0
    var maxValue: Int = 0
    var minValue: Int = 0
    var lenghtOfIntervals: Int = 0
    var valuesForIntervals: [Int] = []
    var stringIntervals: [String] = []
    var frequencies: [Int] = []
    var frequenciesInString: [String] = []
    var xMiddleValues: [Double] = []
    var xMiddleValuesInString: [String] = []
    var sampleMean: Double = 0.0
    var dispersion: Double = 0.0
    var xMiddleMinusSampleMeanSquared: [Double] = []
    var xMiddleMinusSampleMeanSquaredInString: [String] = []
    var meanDeviation: Double = 0.0
    var fashion: Double = 0.0
    var accumulatedFrequencies: [Int] = []
    var accumulatedFrequenciesInString: [String] = []
    var coefficentOfAssimetry: Double = 0.0
    var coefficentOfExcess: Double = 0.0
    var median: Double = 0.0
    var gamma: Double = 0.95
    var a1: Double = 0.0
    var a2: Double = 0.0
    var k: Int = 0
    var dispersionConfidentialInterval: String = ""
    var xConfidentialInterval: String = ""
    
    // MARK: - Functions
    
    func getCSVData() -> Array<String> {
        do {
            let filePath = Bundle.main.path(forResource: "telecom_churn", ofType: "csv")
            guard let filePath = filePath else {
                return []
            }
            let content = try String(contentsOfFile: filePath)
            var parsedCSV: [String] = content.components(
                separatedBy: [","]
            ).map{ $0.components(separatedBy: "\n")[0] }
            parsedCSV.removeFirst()
            csvData = parsedCSV
            return csvData
        }
        catch {
            csvData = []
            return csvData
        }
    }
    
    func getArrayOfNumbers() -> [Int] {
        var arrayOfStringNumbers: [String] = []
        for number in stride(from: 0, through: csvData.count/128, by: 1) {
            arrayOfStringNumbers.append(csvData[number*19])
        }
        arrayOfNumbers = arrayOfStringNumbers.map {
            Int($0) ?? Int.random(in: 30...100)
        }
        return arrayOfNumbers
    }
    
    func getCountOfNumbersInArray() -> Int {
        countOfNumbersInArray = arrayOfNumbers.count
        return countOfNumbersInArray
    }
    
    func getCountOfIntervals() -> Int {
        let lg = log10(Double(countOfNumbersInArray))
        countOfIntervals = Int(1 + 3.322 * lg)
        return countOfIntervals
    }
    
    func getMaxValue() -> Int {
        guard let max = arrayOfNumbers.max() else {
            return 0
        }
        maxValue = max
        return max
    }
    
    func getMinValue() -> Int {
        guard let min = arrayOfNumbers.min() else {
            return 0
        }
        minValue = min
        return min
    }
    
    func getLengthOfInterval() -> Int {
        let maxValue = maxValue
        let minValue = minValue
        let countOfIntervals = countOfIntervals
        lenghtOfIntervals = Int((maxValue - minValue) / countOfIntervals) + 1
        return lenghtOfIntervals
    }
    
    func getValuesForIntervals() -> [Int] {
        var arrayOfValuesForIntervals: [Int] = []
        for value in stride(from: minValue, through: maxValue, by: lenghtOfIntervals) {
            arrayOfValuesForIntervals.append(value)
        }
        guard let last = arrayOfValuesForIntervals.last else {
            return []
        }
        arrayOfValuesForIntervals.append(last + lenghtOfIntervals)
        valuesForIntervals = arrayOfValuesForIntervals
        return valuesForIntervals
    }
    
    func getIntervalsInString() -> [String] {
        var arrayOfStringIntervals: [String] = []
        arrayOfStringIntervals.append("INT")
        for index in 0..<valuesForIntervals.count-1 {
            arrayOfStringIntervals.append("\(valuesForIntervals[index])" + "-" + "\(valuesForIntervals[index+1])")
        }
        stringIntervals = arrayOfStringIntervals
        return stringIntervals
    }
    
    func getFrequency() -> [Int] {
        var count = 0
        var arrayOfFrequencies: [Int] = []
        for index in 0..<valuesForIntervals.count-1 {
            for value in arrayOfNumbers {
                if (value >= valuesForIntervals[index]) && (value < valuesForIntervals[index+1]) {
                    count += 1
                }
            }
            arrayOfFrequencies.append(count)
        }
        for index in 0..<arrayOfFrequencies.count {
            for jndex in 0..<index {
                arrayOfFrequencies[index] = arrayOfFrequencies[index] - arrayOfFrequencies[jndex]
            }
        }
        frequencies = arrayOfFrequencies
        return frequencies
    }
    
    func getFrequencyInString() -> [String] {
        var arrayOfFrequenciesInSting: [String] = []
        arrayOfFrequenciesInSting.append("FRQ")
        for index in 0..<frequencies.count {
            arrayOfFrequenciesInSting.append("\(frequencies[index])")
        }
        frequenciesInString = arrayOfFrequenciesInSting
        return frequenciesInString
    }
    
    func getAccumulatedFrequency() -> [Int] {
        accumulatedFrequencies.append(frequencies.first ?? 0)
        for elem in 0..<frequencies.count-1 {
            var tempValue: Int = 2
            for value in stride(from: elem+1, to: 0, by: -1) {
                tempValue += frequencies[value]
            }
            accumulatedFrequencies.append(tempValue)
        }
        return accumulatedFrequencies
    }
    
    func getAccumulatedFrequencyInString() -> [String] {
        accumulatedFrequenciesInString.append("FRQ(a)")
        for elem in 0..<accumulatedFrequencies.count {
            accumulatedFrequenciesInString.append("\(accumulatedFrequencies[elem])")
        }
        return accumulatedFrequenciesInString
    }
    
    func getXMiddle() -> [Double] {
        var xMiddleArray: [Double] = []
        for index in 0..<valuesForIntervals.count-1 {
            xMiddleArray.append(Double(((valuesForIntervals[index] + valuesForIntervals[index + 1]) / 2)) + 0.5)
        }
        xMiddleValues = xMiddleArray
        return xMiddleValues
    }
    
    func getXMiddleInString() -> [String] {
        var xMiddleArrayInString: [String] = []
        xMiddleArrayInString.append("x(mid)")
        for index in 0..<valuesForIntervals.count-1 {
            xMiddleArrayInString.append("\(xMiddleValues[index])")
        }
        xMiddleValuesInString = xMiddleArrayInString
        return xMiddleValuesInString
    }
    
    func getSampleMean() -> Double {
        var sampleX: Double = 0.0
        for index in 0..<countOfIntervals {
            sampleX += (xMiddleValues[index] * Double(frequencies[index]))
        }
        sampleX = sampleX / Double(countOfNumbersInArray)
        sampleMean = sampleX
        return sampleMean
    }
    
    func getXMiddleMinusSampleMeanSquared() -> [Double] {
        var array: [Double] = []
        for index in 0..<countOfIntervals {
            let temp = (xMiddleValues[index] - sampleMean)
            let temp2 = pow(temp, 2)
            array.append(temp2)
        }
        xMiddleMinusSampleMeanSquared = array
        return xMiddleMinusSampleMeanSquared
    }
    
    func getXMiddleMinusSampleMeanSquaredInString() -> [String] {
        var array: [String] = []
        array.append("(x(mid)-x(выб))^2")
        for index in 0..<countOfIntervals {
            let temp = (xMiddleValues[index] - sampleMean)
            let temp2 = pow(temp, 2)
            array.append(String(format: "%.3f", temp2))
        }
        xMiddleMinusSampleMeanSquaredInString = array
        return xMiddleMinusSampleMeanSquaredInString
    }
    
    func getDispersion() -> Double {
        var dispersion: Double = 0.0
        for index in 0..<countOfIntervals {
            dispersion += xMiddleMinusSampleMeanSquared[index] * Double(frequencies[index])
        }
        dispersion = dispersion / Double(countOfNumbersInArray)
        self.dispersion = dispersion
        return self.dispersion
    }
    
    func getMeanDeviation() -> Double {
        meanDeviation = sqrt(dispersion)
        return meanDeviation
    }
    
    func getFashion() -> Double {
        guard var maxValue = frequencies.first else {
            return 0.0
        }
        var maxIndex = 0
        for (index, value) in frequencies.enumerated() {
            if value > maxValue {
                maxValue = value
                maxIndex = index
            }
        }
        let bottomLine = valuesForIntervals[maxIndex]
        let frequencyOfModalInterval = frequencies[maxIndex]
        let freqOfPreviousModInt = frequencies[maxIndex-1]
        let freqOfFollowingModInt = frequencies[maxIndex+1]
        fashion = Double(bottomLine + (((frequencyOfModalInterval - freqOfPreviousModInt) * lenghtOfIntervals) / ((frequencyOfModalInterval - freqOfPreviousModInt) + (frequencyOfModalInterval - freqOfFollowingModInt))))
        return fashion
    }
    
    func getExcess() -> Double {
        var tempArray: [Double] = []
        var m4: Double = 0.0
        for index in 0..<countOfIntervals {
            xMiddleMinusSampleMeanSquared[index] = sqrt(xMiddleMinusSampleMeanSquared[index])
            let temp = pow(xMiddleMinusSampleMeanSquared[index], 4)
            tempArray.append(temp)
        }
        for index in 0..<countOfIntervals {
            m4 += tempArray[index] * Double(frequencies[index])
        }
        m4 = m4 / Double(countOfNumbersInArray)
        let sampleMeanCubed = pow(sampleMean, 4)
        coefficentOfExcess = m4 / sampleMeanCubed
        coefficentOfExcess -= 3
        return coefficentOfExcess
    }
    
    func getAssymetry() -> Double {
        var tempArray: [Double] = []
        var m3: Double = 0.0
        for index in 0..<countOfIntervals {
            xMiddleMinusSampleMeanSquared[index] = sqrt(xMiddleMinusSampleMeanSquared[index])
            let temp = pow(xMiddleMinusSampleMeanSquared[index], 3)
            tempArray.append(temp)
        }
        for index in 0..<countOfIntervals {
            m3 += tempArray[index] * Double(frequencies[index])
        }
        m3 = m3 / Double(countOfNumbersInArray)
        let sampleMeanCubed = pow(sampleMean, 3)
        coefficentOfAssimetry = m3 / sampleMeanCubed
        return coefficentOfAssimetry
    }
    
    func getMeadian() -> Double {
        guard var maxValue = frequencies.first else {
            return 0.0
        }
        var maxIndex = 0
        for (index, value) in frequencies.enumerated() {
            if value > maxValue {
                maxValue = value
                maxIndex = index
            }
        }
        let bottomLine = valuesForIntervals[maxIndex]
        let frequencyOfModalInterval = frequencies[maxIndex]
        let accFreqOfPreviousModInt = accumulatedFrequencies[maxIndex-1]
        median = Double(bottomLine + (((Int(Double(0.5 * Double(countOfNumbersInArray))) - accFreqOfPreviousModInt) * lenghtOfIntervals) / frequencyOfModalInterval))
        return median
    }
    
    func getA1() -> Double {
        return (1 - gamma) / 2
    }
    
    func getA2() -> Double {
        return (1 + gamma) / 2
    }
    
    func getK() -> Int {
        return countOfIntervals - 1
    }
    
    func getDispersionConfidentialInterval() ->  String {
        let hiSquaredWithA1: Double = 45.7
        let hiSquaredWithA2: Double = 16.0
        let left1 = (Double(countOfNumbersInArray-1) * dispersion) / hiSquaredWithA1
        let right1 = (Double(countOfNumbersInArray-1) * dispersion) / hiSquaredWithA2
        let leftArea = String(format: "%.3f", left1)
        let rightArea = String(format: "%.3f", right1)
        let centerArea = "gener. dispersion"
        dispersionConfidentialInterval = leftArea + " < " + centerArea + " < " + rightArea
        return dispersionConfidentialInterval
    }
    
    func getXConfidentialInterval() -> String {
        let t = 2.045
        let leftArea = sampleMean - (t * meanDeviation / sqrt(Double(countOfNumbersInArray)))
        let left = String(format: "%.3f", leftArea)
        let rightArea = sampleMean + (t * meanDeviation / sqrt(Double(countOfNumbersInArray)))
        let right = String(format: "%.3f", rightArea)
        let center = "gener. x"
        xConfidentialInterval = left + " < " + center + " < " + right
        return xConfidentialInterval
    }
}

