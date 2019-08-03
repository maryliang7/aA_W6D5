class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validate :date_validation

  belongs_to :cat

  def overlapping_requests
    overlapping_requests = []
    cat1 = Cat.find(self.cat_id)
    requests = cat1.cat_rental_requests

    requests.each do |request|
      start = request.start_date
      final = request.end_date
      if (start...final).include?(self.start_date) || (start...final).include?(self.end_date)
        overlapping_requests << request
      end
    end
    overlapping_requests
  end

  def date_validation
    if !overlapping_approved_terequests.empty?
      errors[:start_date] << "Invalid Date"
    end
  end

  def overlapping_approved_requests
    overlapping_requests.select { |request| request.status == 'APPROVED' }
  end


end
