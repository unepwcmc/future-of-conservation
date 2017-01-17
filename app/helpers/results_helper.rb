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

  def format_filters_for_display
    filters = params["filter"].to_unsafe_h
    filters = filters.map do |k, v|
                key = k.gsub('_', ' ').titleize
                val = k == "age" ? "#{v['min']} - #{v['max']}" : v
                "#{key} (#{val})"
              end
    filters.join(", ")
  end
end
