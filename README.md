# Future of Conservation

A quiz app that indentifies your orientation as a conservationist

Just clone and then it's the usual...

`bundle install`
`rails db:create db:migrate`
`rails s`


# Questions

Questions are editable and version controlled thanks to the `paper_trail` gem. Each question has a weight and an axis it corresponds to.
On submission of answers, the questions and the answers get snapshotted and stored as json after a few calculations. This is to ensure we hold
the current state of the question (weightings included) at the time the quiz was answered, incase anything is changed like a weight.
Just for good measure, the `paper_trail` version number of the question is also stored in the json along with the answer.

# AnswerSets

An `AnswerSet` represents all answers to a quiz, jsonified and calculated. AnswerSets are snapshots in time and keep a copy of the questions to future proof any changing of vital information like the weight of a particular question.

AnswerSet's also store an IP address of the request and the finished calculations to make sure they were right at the time of saving.

# DemographicQuestions

Demographic questions are semi editable and always appear at the end of the questionnaire in the order specificed by the position of each question. You can edit the text and position freely, but shortname is restricted.

Because of the variation of the answer types for a demographic question, they each render their own partial stored in `views/survey/demographic_questions` and taking the name of `_short_name.html.erb`, this is what the short name is for, finding the partial, and it also provides a unique identifier of what that answer is stored as in the database. For this reason, editing of short names is restricted for users. Demographic data is also stored in the JSON in an AnswerSet.

# Debug mode

You can append `?debug=true` to the URL in development and staging to remove the Javascript validations for making sure questions are answered before allowing a user to advance pages of the survey
