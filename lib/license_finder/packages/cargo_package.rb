module LicenseFinder
  class CargoPackage < Package
    def initialize(crate, options = {})
      crate.compact!
      children = crate.fetch('dependencies', []).map{|p| p['name']}
      licenses = crate.fetch('license', '').split('/')
      super(
        crate['name'],
        crate['version'],
        options.merge(
          summary: crate.fetch('description', '').strip,
          spec_licenses: licenses.compact,
          children: children,
        )
      )
    end

    def package_manager
      'Cargo'
    end
  end
end
