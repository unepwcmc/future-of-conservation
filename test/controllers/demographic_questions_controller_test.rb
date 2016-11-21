require 'test_helper'

class DemographicQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @demographic_question = demographic_questions(:one)
  end

  test "should get index" do
    get demographic_questions_url
    assert_response :success
  end

  test "should get new" do
    get new_demographic_question_url
    assert_response :success
  end

  test "should create demographic_question" do
    assert_difference('DemographicQuestion.count') do
      post demographic_questions_url, params: { demographic_question: { position: @demographic_question.position, short_name: @demographic_question.short_name, text: @demographic_question.text } }
    end

    assert_redirected_to demographic_question_url(DemographicQuestion.last)
  end

  test "should show demographic_question" do
    get demographic_question_url(@demographic_question)
    assert_response :success
  end

  test "should get edit" do
    get edit_demographic_question_url(@demographic_question)
    assert_response :success
  end

  test "should update demographic_question" do
    patch demographic_question_url(@demographic_question), params: { demographic_question: { position: @demographic_question.position, short_name: @demographic_question.short_name, text: @demographic_question.text } }
    assert_redirected_to demographic_question_url(@demographic_question)
  end

  test "should destroy demographic_question" do
    assert_difference('DemographicQuestion.count', -1) do
      delete demographic_question_url(@demographic_question)
    end

    assert_redirected_to demographic_questions_url
  end
end
