require 'rails_helper'
require_relative '../factories'

RSpec.describe CompaniesController do
  describe 'Companies controller' do
    let!(:company) { FactoryBot.create(:company) }
    let!(:user1) { FactoryBot.create(:user, name: 'admin', company: company) }
    before do
      user1.add_role(user1.name.to_sym, user1.company)
    end
    context '#index' do
      it 'expect sign_in' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      it "redirect to the current_user's profile page" do
        sign_in user1
        get :index
        expect(response.status).to eq(200)
        expect(assigns.keys).to include('company')
        expect(assigns.keys).to include('reports')
        expect(assigns.keys).to include('versions')
      end
    end

    context '#show' do
      before do
        sign_in user1
      end
      it 'View the company details' do
        get :show, params: { id: user1.id }
        expect(response.status).to eq(200)
        expect(assigns[:company].name).to eq(company.name)
      end
    end

    context '#update' do
      before do
        sign_in user1
      end

      it 'Update the company details' do
        expect(user1.company.name).not_to eq('Dr. Luther Simonis modified')
        params = { id: user1.company.id,
                   name: 'Dr. Luther Simonis modified',
                   started_at: DateTime.now,
                   founder_name: 'Founder one modified' }
        patch :update, params: { id: params[:id], company: params }
        expect(assigns[:company].name).to eq('Dr. Luther Simonis modified')
      end
    end
  end
end
