module ResultsHelper
  def format_text(text, s_per_paragraph=2)
    sentences               = text.split('.')
    grouped_sentences, html = [], []

    sentences.each_slice(s_per_paragraph) {|s| grouped_sentences << s }
    grouped_sentences.each do |paragraph|
      paragraph.map! {|t| t + "."}
      html << content_tag(:p, paragraph.join(" "))
    end

    html.join.html_safe
  end
end
