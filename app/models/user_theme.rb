module UserTheme
  THEMES = %w(blue indigo purple pink red orange yellow green teal cyan black gray).freeze

  class << self

    def all
      THEMES
    end

    def detect
      all.sample
    end

    def exist?(theme)
      all.include?(theme)
    end
  end
end
