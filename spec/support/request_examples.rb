module RequestExamples
  shared_examples 'response ok' do
    it 'should respond with status code of 200' do
      expect(response.status).to eq(200)
    end
  end
end

RSpec.configure do |config|
  config.include RequestExamples, type: :request
end
