FactoryGirl.define do
  factory :doorkeeper_application, :class => Doorkeeper::Application do
    name 'Test'
    redirect_uri 'urn:ietf:wg:oauth:2.0:oob'
  end
end
