protocol ViewConfigurator: AnyObject {
    func setup()
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension ViewConfigurator {
    func setup() {
        addViewHierarchy()
        setupConstraints()
        configureViews()
    }
}
