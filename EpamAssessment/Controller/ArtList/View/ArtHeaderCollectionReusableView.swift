//
//  ArtHeaderCollectionReusableView.swift
//  EpamAssessment
//
//  Created by Marcel on 19.05.2024.
//

import UIKit

final class ArtHeaderCollectionReusableView: UICollectionReusableView {

    private let titleLabel = UILabel()
    private var segmentedControl = UISegmentedControl()
    var cultureDidChangeCallback: ((Culture) -> Void)?

    private func setupHeaderViews()   {
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)

        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    private func createSegmentedControl() {
        let items = Culture.allCases.map { $0.displayName }
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(cultureDidChange(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        addSubview(segmentedControl)

        NSLayoutConstraint.activate([
            segmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            segmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            segmentedControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        ])
    }

    @objc func cultureDidChange(_ segmentedControl: UISegmentedControl) {
        let selectedCulture = Culture.allCases[segmentedControl.selectedSegmentIndex]
        cultureDidChangeCallback?(selectedCulture)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeaderViews()
        createSegmentedControl()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }

    func setupHeaderCell(with culture: Culture) {
        let region = culture == .nl ? "Netherlands" : "England"
        titleLabel.text = "Today in \(region)"
    }
}
