class PopulateShortCodesToExistingQuestions < ActiveRecord::Migration[5.0]
  SHORT_NAMES = {
    "Humans are separate from nature, not part of it" => "humans_separate",
    "Conservation will only succeed if it provides benefits for people" => "provides_benefits",
    "Conserving nature for nature's sake should be a goal of conservation" => "nature_sake",
    "Conservation must benefit poor people because to do so is an ethical imperative" => "ethical_imperative",
    "Human impact on nature grows in line with incomes" =>                "impact_incomes",
    "Maintaining ecosystem processes should be a goal of conservation" => "ecosystem_goal",
    "Human affection for nature grows in line with income" =>             "affection_income",
    "Strict protected areas are required to achieve most conservation goals" => "strict_protected_areas",
    "There is no significant conservation value in highly modified landscapes" => "value_landscapes",
    "To achieve conservation goals, the environmental impact of the world's rich must be reduced" => "impact_rich",
    "Having multiple rationales for conservation weakens the conservation movement" => "rationales_weakens",
    "Working with corporations is not just pragmatic; they can be a positive force for conservation" => "corporations_pragmatic",
    "Protecting nature for its own sake does not work" => "own_sake",
    "Conservation will only be a durable success if it has broad public support" => "public_support",
    "The best way for conservation to contribute to human wellbeing is by promoting economic growth" => "economic_growth",
    "Conservation goals should be based on ethical values" => "ethical_values",
    "Conservation goals should be based on science" => "science_based",
    "Conservation actions should primarily be informed by evidence from biological science" => "biological_science",
    "When communities manage their own resources, their efforts are more effective than top-down approaches" => "communities_manage",
    "Conservation should seek to reduce the emotional separation of people from nature" => "emotional_separation",
    "Win-win outcomes for people and nature are rarely possible" => "win_win",
    "Nature often recovers from even severe perturbations" => "severe_perturbations",
    "Conservation should seek to do no harm to poor people" => "seek_no_harm",
    "To achieve its goals, conservation should seek to reform global trade" => "reform_global_trade",
    "Economic arguments for conservation are risky because they can lead to unintended negative conservation outcomes" => "economic_arguments",
    "It is acceptable for people to be displaced to make space for protected areas" => "people_displaced",
    "Conservation should work with, not against, capitalism" => "with_capitalism",
    "Advancing the wellbeing of all people should be a goal of conservation" => "advancing_wellbeing",
    "Conservation communications are more effective when they use negative 'doom and gloom' messages rather than positive messages" => "doom_gloom",
    "Maintaining biological diversity should be a goal of conservation" => "biological_diversity",
    "Non-native species offer little conservation value" => "Non_native_species",
    "Conservation will only be a durable success if it has the support of corporations" => "support_corporations",
    "Giving a voice to those affected by conservation actions improves conservation outcomes" => "giving_voice_improves",
    "To achieve conservation goals, human population growth must be reduced" => "population growth",
    "Giving a voice to those affected by conservation action is an ethical imperative" => "giving_voice_ethical",
    "Conservation messages that emphasise the value of nature for nature's own sake are more effective than those that promote the benefits of nature to humans" => "emphasise_value",
    "There is a risk that economic rationales for conservation will displace other motivations for conservation" => "displace_motivations",
    "Pristine nature, untouched by human influences, does not exist" => "pristine_nature"
  }

  def change
    Question.all.each do |q|
      short_name    = SHORT_NAMES[q.text]
      q.short_code  = short_name
      q.save!

      AnswerSet.all.each do |a|
        puts "Adding short_name #{short_name} to #{a.inspect}"
        answer               = a.find_answer_by_key_value("question_text", q.text)
        next if answer.nil?
        answer["short_name"] = short_name
        a.save!
      end
    end
  end
end
