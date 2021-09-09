require 'rails_helper'
RSpec.describe 'Label management function', type: :system do
    let!(:user) { FactoryBot.create(:user, name: "Johanu", email: "johanugandonou@gmail.com", password: "123456", admin: true)}
    let!(:user1) { FactoryBot.create(:user, name: "Jean", email: "jean@gmail.com", password: "123456", admin: true)}
    before do
        FactoryBot.create(:label, name: "Label1", user_id: user.id)
        visit new_session_path
        fill_in "session[email]",	with: "johanugandonou@gmail.com" 
        fill_in "session[password]",	with: "123456"
        click_on "Se connecter"
    end
    describe 'New creation function' do
        context 'When creating a new label' do
            it 'The created label is displayed' do
                visit labels_path
                expect(page).to have_content 'Label1'
            end
        end
        context "When a user creates a label" do
            it 'Only this user can use it' do
                click_on "Se déconnecter"
                fill_in "session[email]",	with: "jean@gmail.com" 
                fill_in "session[password]",	with: "123456"
                click_on "Se connecter"
                visit labels_path
                expect(page).not_to have_content 'Label1'
            end
        end
        
    end
end