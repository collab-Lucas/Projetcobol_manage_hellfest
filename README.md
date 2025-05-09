# Projetcobol_manage_hellfest
# Projet COBOL - Hellfest Management

## 📌 Présentation

Ce projet a été réalisé dans le cadre d’un travail de groupe en formation.  
Il s'agit d'un système de gestion d’événements inspiré du festival **Hellfest**, développé en **COBOL**.  
L’application permet la gestion des utilisateurs, des concerts et des scènes.

## 👥 Équipe

Projet réalisé en groupe (Groupe 10), dans le cadre d'un projet pédagogique encadré.

## 🛠 Fonctionnalités

- Connexion utilisateur
- Consultation et gestion des concerts
- Consultation des scènes
- Navigation par menu

## 🗂 Structure du projet

- `groupe_10_hellfest.cob` : programme principal
- `groupe_10_menu.cpy` : menu principal
- `groupe_10_connexion.cpy` : gestion de la connexion utilisateur
- `groupe_10_utilisateur.cpy` : gestion des utilisateurs
- `concerts.dat.*`, `scenes.dat.*`, `utilisateurs.dat` : fichiers de données

## ▶️ Compilation & Exécution

> 💡 Pour exécuter ce programme COBOL, il est recommandé d’utiliser [GnuCOBOL](https://sourceforge.net/projects/open-cobol/).

### Compilation

```bash
cobc -x -o hellfest groupe_10_hellfest.cob
Exécution
bash
Copier
Modifier
./hellfest
Assurez-vous que les fichiers .dat soient dans le même répertoire que l’exécutable.

📄 Remarques
Ce projet est purement académique et n’a pas vocation à être utilisé en production.

Le style et l’organisation sont pensés pour un exercice d’apprentissage du COBOL.
