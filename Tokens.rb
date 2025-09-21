class Token
    attr_reader :type, :text, :start, :back
    def initialize(type, text, start, back)
        @type  = type
        @text  = text
        @start = start   # index of first character of the token in the source
        @back  = back    # index of last character of the token in the source (inclusive)
    end
end