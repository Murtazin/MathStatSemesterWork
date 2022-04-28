import UIKit

class CustomTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseIdForCell = "CustomTableViewCell"
    
    lazy var intervalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var frequencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var xMiddleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var xMiddleMinusSampleMeanSquaredLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var accumulatedFrequencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    // MARK: - Overrided
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(intervalLabel)
        contentView.addSubview(frequencyLabel)
        contentView.addSubview(xMiddleLabel)
        contentView.addSubview(xMiddleMinusSampleMeanSquaredLabel)
        contentView.addSubview(accumulatedFrequencyLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        intervalLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.top.equalToSuperview().inset(16)
        }
        frequencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(intervalLabel).inset(70)
            make.centerY.equalTo(intervalLabel)
        }
        xMiddleLabel.snp.makeConstraints { make in
            make.leading.equalTo(frequencyLabel).inset(50)
            make.centerY.equalTo(frequencyLabel)
        }
        xMiddleMinusSampleMeanSquaredLabel.snp.makeConstraints { make in
            make.leading.equalTo(xMiddleLabel).inset(70)
            make.centerY.equalTo(xMiddleLabel)
        }
        accumulatedFrequencyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(xMiddleMinusSampleMeanSquaredLabel)
        }
    }
    
    // MARK: - Functions
    
    func configureCell(with interval: String, frequency: String, xMiddle: String, xMiddleMinusSampleMeanInSquared: String, accumulatedFrq: String) {
        self.intervalLabel.text = interval.description
        self.frequencyLabel.text = frequency.description
        self.xMiddleLabel.text = xMiddle.description
        self.xMiddleMinusSampleMeanSquaredLabel.text = xMiddleMinusSampleMeanInSquared.description
        self.accumulatedFrequencyLabel.text = accumulatedFrq.description
    }
}
