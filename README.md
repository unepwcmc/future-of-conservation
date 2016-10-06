# Future of Conservation

A quiz app that indentifies your orientation as a conservationist

Just clone and then it's the usual...

`bundle install`
`rails db:create db:migrate`
`rails s`

Questions are editable and version controlled thanks to the `paper_trail` gem. Each question has a weight and an axis it corresponds to.
On submission of answers, the questions and the answers get snapshotted and stored as json after a few calculations. This is to ensure we hold
the current state of the question (weightings included) at the time the quiz was answered, incase anything is changed like a weight.
Just for good measure, the `paper_trail` version number of the question is also stored in the json along with the answer.

An `AnswerSet` represents all answers to a quiz, jsonified and calculated. AnswerSets are snapshots in time and keep a copy of the questions to future proof any changing of vital information like the weight of a particular question.

AnswerSet's also store an IP address of the request and the finished calculations to make sure they were right at the time of saving.

