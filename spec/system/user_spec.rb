require 'rails_helper'
RSpec.describe 'Fonction de gestion des utilisateurs', type: :system do
    describe 'Test denregistrement des utilisateurs' do
        context 'Lorsquun nouveau utilisateur est enregistré' do
            it 'Connecter le nouveau utilisateur et acceder à la page de ces détails' do
                visit new_user_path
                fill_in 'user[name]',	with: "Johanu"
                fill_in 'user[email]',	with: "johanugandonou@gmail.com"
                fill_in 'user[password]',	with: "123456"
                click_on 'Créer un(e) User'
                expect(page).to have_content "L'utilisateur a été créé avec succès."
                expect(page).to have_content "Name: Johanu"
                expect(page).to have_content "Email: johanugandonou@gmail.com"
                expect(page).to have_content "Nombre de tâche: 0"
            end
        end
        context 'Lorsque lutilisateur essaie de passer à lécran de la liste des tâches sans se connecter' do
            it 'Passez à lécran de connexion' do
                visit tasks_path
                expect(page).to have_content "Connexion"
            end
        end
    end
    describe 'Test de la fonctionnalité de session' do
        before do
            FactoryBot.create(:user, name: "Johanu", email: "johanugandonou@gmail.com", password: "123456")
            visit new_session_path
            fill_in "session[email]",	with: "johanugandonou@gmail.com" 
            fill_in "session[password]",	with: "123456"
            click_on "Se connecter"
        end
        let!(:user1) { FactoryBot.create(:user, name: "Johanu1", email: "johanugandonou1@gmail.com", password: "123456")}
        context 'Lorsque lutilisateur essaie se connecter avec des identifiant corrects' do
            it "Accéder à la page de la liste des tâches" do
                expect(page).to have_content "Tâches"
            end
        end
        context 'Lorsque lutilisateur essaie de accéder à son écran de détails' do
            it "Afficher la page contenant ces informations" do
                click_on "Ma page"
                expect(page).to have_content "Mes informations"
                expect(page).to have_content "Name: Johanu"
                expect(page).to have_content "Email: johanugandonou@gmail.com"
            end
        end
        context 'Lorsquun utilisateur général passe à lécran des détails dune autre personne' do
            it "Passe à l'écran de la liste des tâches" do
                visit user_path(user1)
                expect(page).to have_content "Tâches"
                expect(page).not_to have_content "Mes informations"
            end
        end
        context 'Lorsque lutilisateur essaie se déconnecter' do
            it "Passez à lécran de connexion" do
                click_on "Se déconnecter"
                expect(page).to have_content "Connexion"
            end
        end
    end
    describe 'Test de lécran dadministration' do
        before do
            FactoryBot.create(:user, name: "Johanu", email: "johanugandonou@gmail.com", password: "123456", admin: true)
            visit new_session_path
            fill_in "session[email]",	with: "johanugandonou@gmail.com" 
            fill_in "session[password]",	with: "123456"
            click_on "Se connecter"
        end
        let!(:user) { FactoryBot.create(:user, name: "Johanu1", email: "johanugandonou1@gmail.com", password: "123456")}
        context 'Losque les lutilisateurs administrateurs essaient dacceder à lécran dadministration' do
            it 'Passez à lécran dadministration' do
                click_on "Tous les utilisateurs"
                expect(page).to have_content "La liste de tous les utilisateurs"
            end
        end
        context 'Losque les lutilisateurs généraux essaient dacceder à lécran dadministration' do
            it 'Passez à la page de la liste des tâches avec un message disant que seul ladministrateurs peut acceder' do
                click_on "Se déconnecter"
                fill_in "session[email]",	with: "johanugandonou1@gmail.com" 
                fill_in "session[password]",	with: "123456"
                click_on "Se connecter"
                visit admin_users_path
                expect(page).to have_content "Tâches"
                expect(page).not_to have_content "La liste de tous les utilisateurs"

            end
        end
        context 'Lorsquun utilisateur administrateur enregistre un nouveau utilisateur' do
            it 'Cet utilisateur apparait dans la liste des utilisateurs' do
                click_on "Tous les utilisateurs"
                click_on "Nouvel utilisateur"
                fill_in 'user[name]',	with: "Toto"
                fill_in 'user[email]',	with: "toto@gmail.com"
                fill_in 'user[password]',	with: "123456"
                click_on 'Créer un(e) User'
                expect(page).to have_content "L'utilisateur a été créé avec succès."
                expect(page).to have_content "Toto"
                expect(page).to have_content "toto@gmail.com"
            end
        end
        context 'Losque les lutilisateurs administrateurs essaient dacceder à lécran des détails dun utilisateur' do
            it 'Passez à lécran des détails de cet utilisateur' do
                click_on "Tous les utilisateurs"
                visit admin_user_path(user)
                expect(page).to have_content "Les informations de cet utilisateur"
            end
        end
        context 'Lorsquun utilisateur administrateur modifie les informations dun utilisateur à partir de lécran dédition' do
            it 'Les modifications seront enregistrer et apparaitront dans la liste des utilisteurs' do
                click_on "Tous les utilisateurs"
                visit edit_admin_user_path(user)
                fill_in 'user[name]',	with: "Toto"
                fill_in 'user[email]',	with: "toto@gmail.com"
                fill_in 'user[password]',	with: "123456"
                click_on 'Modifier ce(tte) User'
                expect(page).to have_content "L'utilisateur a été mis à jour avec succès."
                expect(page).to have_content "Toto"
                expect(page).to have_content "toto@gmail.com"
            end
        end
        context 'Lorsquun utilisateur administrateur supprime un utilisateur' do
            it 'Cet utilisateur ne doit plus apparait dans la liste des utilisateurs' do
                click_on "Tous les utilisateurs"
                find("#supprimer#{user.id}").click
                expect(page).to have_content "L'utilisateur a été détruit avec succès."
                expect(page).not_to have_content "Johanu1"
                expect(page).not_to have_content "johanugandonou1@gmail.com"
            end
        end
    end
end