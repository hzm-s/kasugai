ProjectActivityList = Struct.new(:project, :activities) do
  include Enumerable

  def each(&block)
    activities.each(&block)
  end
end
