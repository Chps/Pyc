module UsersHelper
 def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def country_name(code)
    Carmen::Country.coded(code).name
  end

  def country_helper(f)
    f.country_select(
      :country,
      {
        object:         f.object,
        priority:       ['US'],
        prompt:         'Select country',
        include_blank:  true
      },
      class: 'form-control'
    )
  end

  def birthdate_helper(f)
    f.input(
      :birthdate,
      start_year: 90.years.ago.year,
      end_year:   Time.now.year,
      prompt:     'Select date of birth',
      order:      [:month, :day, :year],
      input_html: { class: 'form-control' }
    )
  end
end
