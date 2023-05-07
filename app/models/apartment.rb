class Apartment < ApplicationRecord
    has_many :tenants, through: :leases
    has_many :leases, dependent: :destroy
end
