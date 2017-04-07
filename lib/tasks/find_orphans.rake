desc 'Finds and reports on answer_sets that wont export because of missing short_name issues'

task find_orphans: :environment do
  orphans             = []
  orphan_answer_sets  = []

  AnswerSet.all.each do |a|
    a.answers["questions"].each do |q|
      if q["short_name"].blank?
        orphans << q
        orphan_answer_sets << a.id
      end
    end
  end

  # Return some info like the count and the strings that weren't caught
  puts "#{orphans.count} Questions couldn't be updated across #{orphan_answer_sets.count}, these are..."

  names = orphans.map{|q| q["question_text"]}.uniq
  names.each {|question_text| puts question_text}

  puts "Can be found in answer sets: #{orphan_answer_sets.join(", ")}"
end
