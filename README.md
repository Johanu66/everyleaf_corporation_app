# README

## Liste des tables

### 1. User
1. name: string
2. email: string
3. password_digest: string

### 2. Task
1. name: string
2. detail: text


## La procédure de deployement d'une application ruby on rails sur heroku


### 1. Se connecter à son compte heroku avec 'heroku login'

### 2. Créer une nouvelle application sur Heroku avec 'heroku create'

### 3. Effectuer une précompilation des actifs avec 'rails assets:precompile RAILS_ENV=production'

### 4. Effectuer un commit

### 5. Déployer vers Heroku l'application proprement dite avec git push heroku main

### 6. Effectuer la migration des bases de données

### 7. Acceder à l'application