# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed Demographic Questions
#
questions = [
  {
    text: "What is your age?",
    position: 1,
    short_name: "age"
  },
  {
    text: "Select your gender?",
    position: 2,
    short_name: "gender"
  },
  {
    text: "At what level is your highest completed educational qualification?",
    position: 3,
    short_name: "education"
  },
  {
    text: "Which of the following best describes your educational specialism?",
    position: 4,
    short_name: "educational_specialism"
  },
  {
    text: "What is your country of nationality?",
    position: 5,
    short_name: "country"
  },
  {
    text: "Where have you done most of your work as a conservationist? Please select up to three countries. You may skip this question if you do not self-identify as someone professionally engaged in conservation",
    position: 6,
    short_name: "location_of_work"
  },
  {
    text: "If more than three, please tell us how many countries you have worked in as a conservationist in total",
    position: 7,
    short_name: "total_countries_worked_in"
  },
  {
    text: "In which of the following sectors have you done conservation work in your career?",
    position: 8,
    short_name: "conservation_sectors"
  },
  {
    text: "Do you have any substantial professional experience in a field other than conservation during your career?",
    position: 9,
    short_name: "experience_in_other_fields"
  },
  {
    text: "In which of the following sectors have you done non-conservation work in your career? Please choose all that apply",
    position: 10,
    short_name: "non_conservation_sectors"
  },
  {
    text: "Which of the following categories best describes your current professional engagement in conservation? Please skip if you are not currently working in a conservation role",
    position: 11,
    short_name: "professional_engagement"
  },
  {
    text: "Which of the following categories best describes the seniority of your current role within conservation?",
    position: 12,
    short_name: "seniority_of_current_role"
  },
  {
    text: "Which of the following categories best describes the context in which you have done most of your professional conservation work?",
    position: 13,
    short_name: "category_of_most_professional_work"
  },
  {
    text: "Do you have any experiences of working as a researcher or as a practitioner on market based schemes in conservation (e.g. payments for ecosystem services, taxes and subsidies, mitigation or species banking, certification)?",
    position: 14,
    short_name: "researcher_experience"
  },
  {
    text: "Please choose up to four of the following items that you believe have been most important in shaping your conservation values",
    position: 15,
    short_name: "value_shaping_items"
  },
  {
    text: "Please feel free to tell us about anything else that you think was important in shaping your values",
    position: 16,
    short_name: "shaping_values"
  },
  {
    text: "Please provide us with your email address so that we can send you summarised results, and to invite you to participate in the survey again in future to see how your views may have changed over time. We will not use your address for any other reason",
    position: 17,
    short_name: "email"
  },
]

questions.each do |question|
  DemographicQuestion.where(short_name: question[:short_name]).first_or_create do |dq|
    dq.text = question[:text]
    dq.position = question[:position]
    puts "Created question with the short_name: #{question[:short_name]}..."
  end
end

classifications = [
  {
    name: "Critical Social Science",
    description: "According to critical social scientists, the impacts of conservation on human wellbeing should be at the forefront of the conservation debate. This entails both being critical of negative side-effects that conservation activities might have on people who are economically poor and/or politically marginalised, and also employing conservation initiatives as a means of improving human welfare. However, critical social scientists tend to be sceptical of the ability of markets and capitalism to deliver benefits for both nature and people. For example, the economic valuation of nature might be perceived as a corporate strategy to open up avenues for its exploitation, whilst concealing the negative impacts of such activities by manipulating the way in which these activities are presented to the public. This position is sometimes critiqued by others for offering a strong diagnosis of what is wrong with conservation practice, whilst failing to offer practical alternatives.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (capitalism & conservation) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the bottom left quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘critical social science’."
  },
  {
    name: "Market Biocentrism",
    description: "Support for an intrinsic value-based rationale for conservation along with a market-based approach to achieving conservation goals is not common in the existing literature. Perhaps one example of such ‘market biocentrism’ is EO Wilson’s recent book ‘Half-Earth’, which advocates the setting aside of half of the Earth’s surface for nature reserves. Aware that this ambitious target would require a drastic decrease in per capita environmental footprint worldwide, Wilson advocates free markets as a means to favour those products which yield the maximum profit for the minimum energy and resource consumption. However, Wilson’s pro-markets view seems to be more to do with ensuring that humanity can flourish on only 50% of the Earth’s surface rather than as a tool for carrying out conservation: that is, the pro-market strategy would be used to buffer the ‘human’ half of the Earth against the need to exploit the ‘natural’ half, rather than as a means to create economic value from protecting the ‘natural’ half.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the top right quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘market biocentrism’."
  },
  {
    name: "New Conservation",
    description: "Central to the ‘new conservation’ position is a shift towards framing conservation as being about protecting nature in order to improve human wellbeing (especially that of the poor), rather than for biodiversity’s own sake. ‘New conservationists’ believe that win-win situations in which people benefit from conservation can often be achieved by promoting economic growth and partnering with corporations. Although new conservation advocates have been criticised for doing away with nature’s intrinsic value, key authors within the movement have responded by clarifying that their motive is not so much an ethical as a strategic or pragmatic one. In other words, they claim that conservation needs to emphasise nature’s instrumental value to people because this better promotes support for conservation compared to arguments based solely on species’ rights to exist.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the top left quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of ‘new conservationists’ as set out in the literature."
  },
  {
    name: "Traditional Conservation",
    description: "Traditional conservationists often support the protection of nature for its own sake. This emphasis on nature’s intrinsic value typically leads traditional conservation advocates to be critical of markets and economic growth as tools for conservation. This is because they believe that by embracing markets, we run the risk of ‘selling out nature’ by neglecting species that may be considered to be of little economic value. What’s more, economic growth itself is seen as a major driver of threats to biodiversity. Traditional conservationists often defend their position by claiming that there is nothing new in ‘new conservation’, noting for example that conservation has for a long time kept human wellbeing in mind and tried to minimise any negative impacts it may have had on local communities. Traditional conservationists typically favour protected areas, particularly in ecosystems with relatively low human impacts, as a primary conservation strategy.",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the bottom right quadrant of the graph – a position suggesting your views on these particular dimensions of the debate are most closely related to those of what we call ‘traditional conservation’."
  },
  {
    name: "Undecided",
    description: "You are undecided",
    results_description: "Your position on the two axes above reflects your survey answers. A move from left to right along the horizontal axis (people & nature) implies a shift from seeing conservation as a means of improving human welfare to conservation for nature’s own sake. The vertical axis (conservation & capitalism) indicates a spectrum of willingness to embrace markets and capitalism as conservation tools: the higher up the graph your score is, the more pro-markets it is. This places you in the centre of the graph – a position suggesting your views on these particular dimensions of the debate are most closely shared between all areas."
  }
]

classifications.each do |classification|
  cls = Classification.where(name: classification[:name]).first_or_create do |c|
    c.description = classification[:description]
    c.results_description = classification[:results_description]
    puts "Created classification with the name: #{classification[:name]}..."
  end

  # If there is a change from the saved record, update it
  unless cls.description == classification[:description] ||
    cls.results_description == classification[:results_description] ||
    cls.name == classification[:name]

    cls.update_attributes(
      name:                 classification[:name],
      description:          classification[:description],
      results_description:  classification[:results_description]
    )
  end
end

