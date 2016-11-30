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
]

questions.each do |question|
  DemographicQuestion.where(short_name: question[:short_name]).first_or_create do |dq|
    dq.text = question[:text]
    dq.position = question[:position]
    puts "Created question with the short_name: #{question[:short_name]}..."
  end
end

