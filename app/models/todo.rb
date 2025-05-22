class Todo < ApplicationRecord

    #validations
    validates :title, presence: true, length: {minimum: 3, maximum: 50}
    validates :description, presence: true, length: {minimum: 4}, uniqueness: true
    valid_statuses = %w[pending ongoing completed]
    validates :status, presence: true, inclusion: {in: valid_statuses, message: "%{value} is not a valid status. the valid statuses are: #{valid_statuses.join(', ')}" }

end
