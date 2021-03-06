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
                key = t("results.#{key.parameterize.underscore}")
                val = t("results.#{val.parameterize.underscore}") unless k == "age"
                "#{key} (#{val})"
              end
    filters.join(", ")
  end

  def format_results_strength(result, axis)
    case axis
    when :x
      polarity = result.x_axis_scaled > 0.0 ? "positive" : "negative"
      strength = result.classification_strength_x
    when :y
      polarity = result.y_axis_scaled > 0.0 ? "positive" : "negative"
      strength = result.classification_strength_y
    end

    i18n_strength = t("results.#{strength}ly")
    i18n_polarity = t("results.#{polarity}")

    "#{i18n_strength} #{i18n_polarity}"
  end
end
