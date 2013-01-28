module Tenantfy
  class Url < ActiveRecord::Base
    belongs_to :tenant, inverse_of: :urls
    attr_accessible :url
    validates :url, presence: true, uniqueness: true
    validates :tenant_id, presence: true
  end
end
