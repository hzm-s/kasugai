ProjectActivityList = Struct.new(:project_id, :activities) do

  def inspect
    %|@project_id="#{project_id}",@activities="#{activities.map(&:id)}"|
  end
end
