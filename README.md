# T-DEV-700 | DevOps

## Installation

## Configuration

## Technologie et Architecture

### Front

#### Technologie :

La technologie utilisée pour la partie front-end est Next.js avec TypeScript. Next.js permet de créer des applications web performantes (Avec La Base de React). Couplé à TypeScript, il assure un typage statique, réduisant les erreurs et facilitant la maintenance du code. Cette combinaison permet de gagner du temps de développement .

#### Architecture :

L'Architecture de l'application web suis les bases du MVC.

Le fonctionnement de Next js réside dans une meilleure organisation et gestion de projet sur le long terme d'un projet:

l'arborescence dans **app** construit les liens routers (Example: https://MonSiteWeb/login)
- **app** : Partie avec les vue des pages
  - **login** : Contient la page login
    - **components** : composants de la page login
    - **pages.tsx** : page login '/login'
  - **pages.tsx**: Correspondant à la page initiale a la racine '/'
- **controllers** : Contient les controllers pour assuerer les données échangées
  - **userController** : controller pour les données sur les utilisateurs
- **lib**:
  -**api**: Contient le traitement des appels a l'api
- **models**: Model des différentes entités présente dans la base
  -User.ts: Model de l'utilisateur

### Back

#### Technologie :

La technologie utilisée pour la partie back-end est le framework Symfony utilisant le langage PHP, ce langage permet l'implémentation d'un serveur back-end plutôt rapidement grâce
au PHP qui est là depuis longtemps et donc plus connu, ce qui en a fait un bon choix pour ce projet.

#### Architecture :

Le type d'architecture utilisé par le back-end est une implémentation REST Headless (Retour JSON au lieu de vues) par un schéma MVC soit Model-View-Controller.

Le MVC nous permet de distinguer concrétement chaque partie du projet avec nos modèles qui sont les réplicas de notre base, les services qui font le lien entre les modèles et les controlleurs et du coup les controlleurs qui permettent de rediriger un appel à un service par rapport à un appel api externe de notre front ou mobile.

- **Models**
- **Views** (Dans notre cas pas utilisé)
- **Services**
- **Controllers**

### Mobile

#### Technologie :

La Technologie utilisée pour la partie mobile est le framework flutter, il permet un développement universel que ce soit pour l'application ios ou android. Elle permet donc un gain de temps significatif de développement par rapport aux langages traditionnels des systèmes d'exploitations mobiles.

#### Architecture :

L'Architecture de l'application mobile est la clean architecture liée à un fonctionnement par features.

Le fonctionnement de la clean architecture réside dans une meilleure organisation et gestion de projet sur le long terme d'un projet. Elle fonctionne en définisant 3 grandes parties à partir d'une feature initiale :

- **Data** : Partie traitant avec la base de donnée (local / remote)
  - **data_sources** : Connexion à la bdd
  - **models** : Modèle lié à la bdd
  - **repositories** : Lien entre data et domain
- **Domain** : Lien entre les données brutes de data et les données renvoyés dans presentation
  - **repositories** : Lien entre domain et data
  - **entities** : Modèle traité pour la partie présentation
  - **usecases** : Les cas d'utilisations
- **Presentation** : Récupère les informations de domain déjà traités et prêtes à être utilisées
  - **pages** : Page ou affichage distinctes
  - **widgets** : Widgets de la page
  - **bloc** : Gestion des événements

Chacune de ces parties s'occupent indépendemment de ce qui est nécessaire et évite au maximum les dépendances avec les autres parties du projet. Cela permet plusieurs avantages :

- **Testabilité** : Les couches sont indépendantes et testables en isolation.
- **Scalabilité** : Chaque couche peut évoluer indépendamment.
- **Flexibilité** : Changer une technologie ne nécessite pas de modifier la logique métier.

Exemple : Migrer Hive vers Sqlite

Si nous voulons migrer de Hive vers Sqlite, il nous faudrait simplement modifier la récupèration des données par rapport à notre base locale. Etant donné que notre modèle ne devrait pas changer, aucune partie ne serait impacté. Et même si cela devait être modifier, il suffirait de modifier le modèle et de redéfinir la fonction inclut dans celle-ci qui envoie les données en tant qu'entité dans le domain.

# T-DEV-700 | Front

## Installation et Configuration

### Installation 

npx create-next-app@latest

- What is your project named? front
- Would you like to use TypeScript? Yes
- Would you like to use ESLint? No (finalement intégrer plus tard)
- Would you like to use Tailwind CSS? Yes
- Would you like your code inside a `src/` directory? Yes
- Would you like to use App Router? (recommended) Yes
- Would you like to use Turbopack for `next dev`? Yes
- Would you like to customize the import alias (`@/*` by default)? Yes
- What import alias would you like configured? @/*

npx shadcn@latest init (ajout de shadcn) https://ui.shadcn.com/docs/installation/next

### Configuration
npm install

Créer le fichier .env (disponible sur discord):

avec API_URL='...'

#### Commandes :
npm run dev (dev)
npm start (prod)

# T-DEV-700 | Back

## Installation et Configuration

### Installation

php : 8.2
symfony : 5.10
composer : 2.5.5

curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash
sudo apt install symfony-cli

composer install

### Configuration

Créer le fichier .env (disponible sur discord)
Générer les fichiers jwt (voir ci-dessous)

#### Commandes :

- **Créer admin** : php bin/console app:create-admin
- **Nettoyer cache** : php bin/console cache:clear
- **Générer keys Jwt** : php bin/console lexik:jwt:generate-keypair
- **Insérer les fixtures** : php bin/console doctrine:fixtures:load
- **Réinsérer les fixtures** : php bin/console doctrine:fixtures:load --purge-with-truncate
- **Drop la base** : php bin/console doctrine:database:drop --force
- **Créer la base** : php bin/console doctrine:database:create
- **Générer le fichier de migration** : php bin/console doctrine:migrations:diff
- **Migrer le fichier de migration vers la base** : php bin/console doctrine:migrations:migrate
- **Démarrer serveur** : symfony server:start
- **Lancer les tests** : composer run test

# T-DEV-700 | Mobile

L'APK peut etre telecharge via l'URL: https://tdevapp.s3.eu-north-1.amazonaws.com/app-release.apk

## Installation et Configuration

### Installation

Java : 19.0.2
Flutter : 3.24.5
Dart : 3.5.4

flutter pub get

Download link: https://tdevapp.s3.eu-north-1.amazonaws.com/app-release.apk

#### Commandes :

- **Run project on emulator** : flutter run
- **Build apk** : flutter build apk --release
- **Build appbundle (aab)** : flutter build appbundle
- **Build ipa (OIS)** : flutter build ipa --no-codesign
- **Lancer les tests** : flutter test
- **Vérifier les tests ESLint** : flutter analyze

### Configuration