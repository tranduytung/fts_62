module AnswersHelper
  def background_for answer, result
    if answer.is_correct?
      content_tag :div, answer.content, class: "list-group-item-success"
    elsif result.answer == answer
      content_tag :div, answer.content, class: "list-group-item-danger"
    else
      content_tag :div, answer.content
    end
  end
end
