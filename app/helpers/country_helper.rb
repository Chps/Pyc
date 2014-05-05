module CountryHelper

  def country_name(code, default = '')
    coded = Carmen::Country.coded(code)
    if coded
      coded.name
    else
      default
    end
  end

end
