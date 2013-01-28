# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tenant, class: 'Tenantfy::Tenant' do
    name  { "tenant_#{Random.rand 10000}" }
    theme { "tenant_#{Random.rand 100}"}
    description { "tenant_#{Random.rand 1000}" }
    keywords { "tenant_#{Random.rand 1000}" }

    trait :with_url do
      urls { [FactoryGirl.create(:url)] }
    end
  end
end

