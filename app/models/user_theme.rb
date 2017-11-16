module UserTheme
  THEMES = %w(blue indigo purple pink red orange yellow green teal cyan black gray).freeze

  class << self

    def all
      THEMES
    end

    def detect
      all.sample
    end
  end
end
