# frozen_string_literal: true

class Post < ApplicationRecord
  before_save :extract
  validates_presence_of :title

  private

  def extract
    parsed_matter = FrontMatterParser::Parser.new(:md).call(raw)
    front_matter = parsed_matter.front_matter
    self.title = front_matter['title']
    self.url = front_matter['url']
    self.aliases = front_matter['aliases']
    self.tags = front_matter['tags']
    self.html = render_content parsed_matter.content
    self.published = front_matter['published']
  end

  class PygmentedHTML < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language, options: {encoding: 'utf-8'})
    end
  end

  def render_content(content)
    markdown = Redcarpet::Markdown.new(PygmentedHTML.new(render_options: {with_toc_data: true}),
                                       autolink: true, no_intra_emphasis: true, fenced_code_blocks: true, lax_spacing: true)
    markdown.render(content).html_safe
  end
end
