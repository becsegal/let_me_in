# https://gist.github.com/1361367

require 'handlebars'
require 'let_me_in/handlebars_config'

module HandlebarsTemplateHandler
  def self.call(template)
    if template.locals.include? :hbs
      <<-TEMPLATE
      template = Handlebars.compile #{template.source.inspect}
      template.call(hbs || {}).html_safe
      TEMPLATE
    else
      <<-SOURCE
      #{template.source.inspect}.html_safe
      SOURCE
    end
  end
end

# Register HBS template handler to render Handlebars templates
ActionView::Template.register_template_handler(:hbs, HandlebarsTemplateHandler)
puts "registered template handler"