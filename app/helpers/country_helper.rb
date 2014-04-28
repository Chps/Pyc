module CountryHelper

  def country_name(code)
    Carmen::Country.coded(code).name
  end

end
