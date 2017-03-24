# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  if debugMode()
    alert("Debug mode is on, all validations will be skipped")

  # Hide all pages except first one
  $('section.survey__page').not(':eq(0)').hide()

  # On next page click
  $('.survey__next-page').click (e) ->
    e.preventDefault()
    currentPage = $('section.survey__page:visible')

    if checkAllQuestionsAnswered(currentPage)
      nextPage()
      toggleSurveyControls($('section.survey__page:visible'))
    else
      alert("There are unanswered questions on this page!")

  # On previous page click
  $('.survey__previous-page').click (e) ->
    e.preventDefault()
    previousPage()
    toggleSurveyControls($('section.survey__page:visible'))




checkAllQuestionsAnswered = (sectionName) ->
  # Gets all questions in the section and checks that each one is answered
  if debugMode() # Skip validations
    true
  else
    questions = $(sectionName).find('.survey__question')
    unansweredQuestions = (question for question in questions when checkQuestionAnswered(question) is false)
    unansweredQuestions.length == 0

checkQuestionAnswered = (question) ->
  if $(question).hasClass("survey__question--optional")
    true
  else
    # Gets all inputs for a given question and check none are unanswered
    inputs = $(question).find('input')
    if inputs.filter(':checked').length == 0
      false
    else
      true

isDemographicSection = (sectionName) ->
  $(sectionName).hasClass('demographic')

nextPage = () ->
  # Advance to the next page
  pages = $('section.survey__page')
  currentPage = $('section.survey__page:visible')
  currentPageIndex = pages.index(currentPage)
  nextPageIndex = currentPageIndex + 1
  # show page at next index unless end of array in which case grey out the next button
  if nextPageIndex >= pages.length
    alert("You're already on the last page!")
  else
    $(pages[nextPageIndex]).show()
    $('html,body').scrollTop(0)
    currentPage.hide()


previousPage = () ->
  # Return to the previous page
  pages = $('section.survey__page')
  currentPage = $('section.survey__page:visible')
  currentPageIndex = pages.index(currentPage)
  prevPageIndex = currentPageIndex - 1
  if prevPageIndex < 0
    alert("Can't go back!")
  else
    $(pages[prevPageIndex]).show()
    $('html,body').scrollTop(0)
    currentPage.hide()

# Helpers
getCurrentPageIndex = (currentPage) ->
  pages = $('section.survey__page')
  pages.index(currentPage)

isLastPage = (currentPage) ->
  currentPageIndex = getCurrentPageIndex(currentPage)
  pages = $('section.survey__page')
  currentPageIndex == (pages.length - 1)

toggleSurveyControls = (currentPage) ->
  # Hide the next page button if this is the last page
  if isLastPage(currentPage)
    $('.survey__submit').show()
    $('.survey__next-page').hide()
  else
    $('.survey__next-page').show()

debugMode = () ->
  # Set ?debug=true in the query string in development or staging to bypass validation
  environment = $('body').data('env')
  queryString = window.location.search.substring(1)
  params = queryString.split("&")
  for param in params
    pair = param.split("=")
    if(pair[0] == "debug") and (pair[1] == "true") and (environment == "development" || environment == "development")
      return true
