module TopN
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def top(number)
      all.sort_by(&:average_rating).reverse!.take(number)
    end
  end
end
