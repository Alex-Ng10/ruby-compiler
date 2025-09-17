class Token
    attr_reader :type, :text, :start, :back
    def initialize(type, text, start, back)
        @type  = type
        @text  = text
        @start = start
        @back  = back
    end
end