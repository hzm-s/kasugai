module ActivityList
  class Daily < Struct.new(:date, :project_list)
    delegate :today?, to: :date

    class << self

      def parse(records)
        records
          .group_by { |r| r.date }
          .map { |date, subset| new(date, subset) }
      end
    end
  end
end
