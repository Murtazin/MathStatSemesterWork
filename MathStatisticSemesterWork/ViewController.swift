import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var csvData: [String]?
    var arrayOfNumbers: [Int]?
    var countOfNumbersInArray: Int?
    var countOfIntervals: Int?
    var maxValue: Int?
    var minValue: Int?
    var lengthOfInterval: Int?
    var valuesForIntervals: [Int]?
    var arrayOfValuesForIntervals: [String]?
    var frequencies: [Int]?
    var arrayOfFrequencies: [String]?
    var arrayOfXMiddleValues: [Double]?
    var arrayOfXMiddleValuesInString: [String]?
    var sampleMean: Double?
    var xMiddleMinusSampleMeanSquared: [Double]?
    var xMiddleMinusSampleMeanSquaredInString: [String]?
    var dispersion: Double?
    var meanDeviasion: Double?
    var fashion: Double?
    var accumulatedFrequencies: [Int]?
    var accumulatedFrqInString: [String]?
    var coefficientOfAssimetry: Double?
    var coefficientOfExcess: Double?
    var median: Double?
    var gamma: Double?
    var a1: Double?
    var a2: Double?
    var k: Int?
    var dispersionConfidentialInterval: String?
    var xConfidentialInterval: String?
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    lazy var checkoutChartsBarButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Checkout bar charts", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(checkoutButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Overrided

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getData()
        setUpTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpConstraints()
    }
    
    // MARK: - Private functions
    
    private func setUpView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(checkoutChartsBarButton)
    }
    
    private func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdForCell)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell3")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell4")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell5")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell6")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell7")
    }
    
    private func setUpConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        checkoutChartsBarButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func getData() {
        csvData = DataManager.shared.getCSVData()
        arrayOfNumbers = DataManager.shared.getArrayOfNumbers()
        countOfNumbersInArray = DataManager.shared.getCountOfNumbersInArray()
        countOfIntervals = DataManager.shared.getCountOfIntervals()
        maxValue = DataManager.shared.getMaxValue()
        minValue = DataManager.shared.getMinValue()
        lengthOfInterval = DataManager.shared.getLengthOfInterval()
        valuesForIntervals = DataManager.shared.getValuesForIntervals()
        arrayOfValuesForIntervals = DataManager.shared.getIntervalsInString()
        frequencies = DataManager.shared.getFrequency()
        arrayOfFrequencies = DataManager.shared.getFrequencyInString()
        arrayOfXMiddleValues = DataManager.shared.getXMiddle()
        arrayOfXMiddleValuesInString = DataManager.shared.getXMiddleInString()
        sampleMean = DataManager.shared.getSampleMean()
        xMiddleMinusSampleMeanSquared = DataManager.shared.getXMiddleMinusSampleMeanSquared()
        xMiddleMinusSampleMeanSquaredInString = DataManager.shared.getXMiddleMinusSampleMeanSquaredInString()
        dispersion = DataManager.shared.getDispersion()
        meanDeviasion = DataManager.shared.getMeanDeviation()
        fashion = DataManager.shared.getFashion()
        accumulatedFrequencies = DataManager.shared.getAccumulatedFrequency()
        accumulatedFrqInString = DataManager.shared.getAccumulatedFrequencyInString()
        coefficientOfAssimetry = DataManager.shared.getAssymetry()
        coefficientOfExcess = DataManager.shared.getExcess()
        median = DataManager.shared.getMeadian()
        gamma = DataManager.shared.gamma
        a1 = DataManager.shared.getA1()
        a2 = DataManager.shared.getA2()
        k = DataManager.shared.getK()
        dispersionConfidentialInterval = DataManager.shared.getDispersionConfidentialInterval()
        xConfidentialInterval = DataManager.shared.getXConfidentialInterval()
    }
    
    @objc private func checkoutButtonDidPressed() {
        let vc = BarChartsViewController()
//        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let arrayOfStringValuesForIntervals = arrayOfValuesForIntervals else {
            return 0
        }
        return arrayOfStringValuesForIntervals.count+9
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let countOfIntervals = countOfIntervals else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0...countOfIntervals:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdForCell, for: indexPath) as? CustomTableViewCell, let arrayOfStringValuesForIntervals = arrayOfValuesForIntervals, let arrayOfFrequencies = arrayOfFrequencies, let arrayOfXMiddle = arrayOfXMiddleValuesInString, let xMiddleMinusSampleMeanSquared = xMiddleMinusSampleMeanSquaredInString, let accumulatedFrq = accumulatedFrqInString else {
                return UITableViewCell()
            }
            let interval = arrayOfStringValuesForIntervals[indexPath.section]
            let frequency = arrayOfFrequencies[indexPath.section]
            let xMiddle = arrayOfXMiddle[indexPath.section]
            let xMidMinSamMeanSq = xMiddleMinusSampleMeanSquared[indexPath.section]
            let accFrq = accumulatedFrq[indexPath.section]
            cell.configureCell(with: interval, frequency: frequency, xMiddle: xMiddle, xMiddleMinusSampleMeanInSquared: xMidMinSamMeanSq, accumulatedFrq: accFrq)
            return cell
        case countOfIntervals+1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
            guard let sampleMean = sampleMean else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("x(выборочное)" + "  =  " + "\(sampleMean)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            guard let dispersion = dispersion else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("выб. дисп." + " = " + "\(dispersion)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
            guard let meanDeviasion = meanDeviasion else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("выб. станд. откл." + " = " + "\(meanDeviasion)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
            guard let fashion = fashion else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("мода" + " = " + "\(fashion)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath)
            guard let coefficientOfAssymetry = coefficientOfAssimetry else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("ассиметрия" + " = " + "\(coefficientOfAssymetry)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell6", for: indexPath)
            guard let coefOfExc = coefficientOfExcess else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("эксцесса" + " = " + "\(coefOfExc)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath)
            guard let median = median else {
                return UITableViewCell()
            }
            cell.textLabel?.text = String("медиана" + " = " + "\(median)")
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+8:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath)
            guard let temp = dispersionConfidentialInterval else {
                return UITableViewCell()
            }
            cell.textLabel?.text = temp
            cell.textLabel?.textAlignment = .left
            return cell
        case countOfIntervals+9:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7", for: indexPath)
            guard let temp = xConfidentialInterval else {
                return UITableViewCell()
            }
            cell.textLabel?.text = temp
            cell.textLabel?.textAlignment = .left
            return cell
        default:
            return UITableViewCell()
        }
    }
}
