module MyMarkdown
  def self.render(text)
    render_options = {
      filter_html:     true,
      hard_wrap:       true,
      link_attributes: { rel: 'nofollow' },
      prettify:        true
    }
    renderer = Redcarpet::Render::HTML.new(render_options)

    extensions = {
      autolink:           true,
      fenced_code_blocks: true,
      lax_spacing:        true,
      no_intra_emphasis:  true,
      strikethrough:      true,
      superscript:        true,
      tables:             true,
      highlight:          true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end
end