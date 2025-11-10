require 'rails_helper'

RSpec.describe "Forecasts", type: :request do
  it 'redirects back if address is missing' do
    post forecasts_path, params: { address: '' }
    expect(response).to redirect_to(root_path)
  end

end
