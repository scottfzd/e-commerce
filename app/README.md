### Détails de notre architecture

1. **Dossier `core`** :
   - Ce dossier centralise toutes les constantes, paramètres globaux, et éléments partagés nécessaires à l’ensemble de l’application.

2. **Dossier `shared`** :
   - Ce dossier regroupe des éléments transversaux ou partagés entre différentes fonctionnalités, comme des widgets communs, des blocs partagés ou des helpers.

3. **Dossier `features`** :
   - Le dossier `features` regroupe les fonctionnalités en suivant le schéma de la Clean Architecture, avec trois sous-dossiers principaux :
      - **Data** : Cette couche contient les interactions avec les sources de données. Elle est divisée en :
         - `data_sources` : Contient les sources de données, qu’elles soient locales (SQLite, SharedPreferences) ou distantes (API).
         - `models` : Définit les modèles de données utilisés dans cette couche, souvent pour des conversions (comme JSON).
         - `repositories` : Implémentations concrètes des repositories, chargées de faire le lien entre les `data_sources` et la couche `domain`.
      - **Domain** : Contient la logique métier pure de l’application, avec une structure typique de la Clean Architecture :
         - `entities` : Définit les entités, qui représentent les objets métier essentiels.
         - `repositories` : Interfaces pour les repositories, indépendantes des implémentations concrètes de la couche `data`.
         - `usecases` : Définit les cas d’utilisation, qui sont des actions ou fonctionnalités principales que l’application peut effectuer.
      - **Presentation** : Gère l’interface utilisateur et la logique de présentation :
         - `pages` : Contient les pages ou écrans de votre application.
         - `bloc` : Inclut les blocs ou cubits pour la gestion des états de la couche de présentation.
         - `widgets` : Regroupe les widgets spécifiques à la fonctionnalité ou à la page.

### Type de schéma utilisé

- **Clean Architecture** : En séparant les données, la logique métier (domain), et la présentation, cela permet de gérer les dépendances entre les couches de manière inversée, ce qui facilite le test unitaire et l'évolution de votre code.
  
- **Feature-first Architecture** : Chaque fonctionnalité est dans un dossier `features` avec ses propres sous-dossiers (`data`, `domain`, `presentation`), ce qui permet de centraliser tout le code lié à une fonctionnalité spécifique, comme `auth`, `profile`, etc. Cela rend chaque fonctionnalité modulaire et plus facile à gérer.

### Résumé

Nous suivons un schéma de dossiers **Feature-first** structuré selon la **Clean Architecture**.