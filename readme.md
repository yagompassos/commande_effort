# TP 1 : Commande en Effort d'un Robot Plan 2R

[![MATLAB](https://img.shields.io/badge/MATLAB-R2023b%2B-blue.svg)](https://www.mathworks.com/)
[![Simulink](https://img.shields.io/badge/Simulink-Validated-orange.svg)](https://www.mathworks.com/products/simulink.html)
[![LaTeX](https://img.shields.io/badge/LaTeX-Overleaf-green.svg)](https://www.overleaf.com/)

Ce dépôt contient l'ensemble des fichiers de simulation, des scripts d'initialisation et la rédaction en LaTeX du **TP1 - Commande en Effort** (Modélisation et Commande Avancée, MEA5 Polytech Montpellier).

---

## Description du Projet

L'objectif de ce TP est d'étudier et de comparer deux lois de commande en effort pour un robot manipulateur plan 2R interagissant avec un environnement élastique de raideur $K_e$ :
1. **Commande en effort basée sur une boucle interne en position** (correcteurs P et PI).
2. **Commande en effort basée sur une boucle interne en vitesse** (correcteur P).

---

## 📂 Structure du Dépôt

```text
.
├── solve_tp.m            # Script MATLAB d'initialisation et de plot
├── robot_2int.slx       # Modèle Simulink (Boucle interne en position)
├── robot_2int_PI.slx       # Modèle Simulink (Boucle interne en position, avec controleur intégrateur)
├── x2partie.slx        # Modèle Simulink (Boucle interne en vitesse)
└── README.md
```

---

## Utilisation

### Prerequisites
* MATLAB R2020b ou supérieur
* Simulink

### Execution Procedure
1. Ouvrir MATLAB et se placer à la racine du dépôt.
2. Exécuter le script de configuration initiale :
   ```matlab
   run('main_script.m')
   ```
3. Ouvrir et lancer les simulations Simulink (`model_position.slx` ou `model_vitesse.slx`).
4. Re-lancer la section de plot dans `main_script.m` pour visualiser le comportement dynamique et la trajectoire de l'Organe Terminal (OT).

---

## Résumé des Résultats

| Architecture | Correcteur | Erreur Statique $\varepsilon_s$ | Dynamique / Temps de réponse |
| :--- | :---: | :---: | :--- |
| **Boucle Position** | **P** | non nulle ($\approx 0.011\text{ N}$) | Transitoire stable, dépend de la raideur |
| **Boucle Position** | **PI** | **0 N** | Sans erreur, réponse amortie |
| **Boucle Vitesse** | **P** | **0 N** | **Très rapide**, profil quasi échelon ("carré") |

---

## Auteur
* **Yago Milagres Passos** -- *Polytech Montpellier*