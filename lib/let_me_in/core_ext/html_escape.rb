# http://www.brendankemp.com/blog/2012/04/30/regexp-match-against-utf-8-warning-in-cucumber/
class ERB
  module Util
    def html_escape(s)
      s = s.to_s
      if s.html_safe?
        s
      else
        s.encode(s.encoding, :xml => :attr)[1...-1].html_safe
      end
    end
    alias h html_escape
    module_function :h
    module_function :html_escape
  end
end