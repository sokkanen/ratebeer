module TopN
  extend ActiveSupport::Concern
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def top(n)
      all.sort_by(&:average_rating).reverse!.take(n)
    end
  end
end
