# KYC Flutter App 🚀📱

Bienvenue dans l'application mobile **KYC (Know Your Customer)**, développée avec **Flutter**. Cette application permet aux utilisateurs de scanner leurs cartes d'identité, de gérer leurs données personnelles et de bénéficier d'une sécurité optimale.

---

## ✨ Fonctionnalités principales

✅ **Onboarding** moderne avec plusieurs pages d'introduction.

🆔 **Scan automatique** des cartes d'identité et extraction intelligente des données.

📊 **Visualisation** et **gestion** des données utilisateur dans une interface fluide.


---

## 📂 Structure du projet

```bash
lib/
├── Pages/
│   ├── onboarding_page.dart    
│   ├── home_screen.dart
│   ├── methode_choice_screen.dart
│   ├── scan_screen.dart
│   ├── scan_face_screen.dart 
├── Widgets/
│   └── build_scan_button.dart     
├── main.dart                     
```

---

## 📦 Technologies & Packages utilisés

| Technologie / Package                                                                                | Description                                            |
| ---------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| <img src="https://img.icons8.com/color/48/flutter.png" width="20"/> [`Flutter`](https://flutter.dev) | Framework UI pour créer l'application.                 |
| [`adria_kyc_integration`](https://github.com/Abdelali-Moutawassit/adria_kyc_flutter_android)         | Intégration KYC avec analyse automatique.              |
| [`introduction_screen`](https://pub.dev/packages/introduction_screen)                                | Gestion de l'onboarding.                               |
| [`shared_preferences`](https://pub.dev/packages/shared_preferences)                                  | Sauvegarde locale des données (ex: statut onboarding). |
| [`google_fonts`](https://pub.dev/packages/google_fonts)                                              | Personnalisation des polices.                          |
| [`carousel_slider`](https://pub.dev/packages/carousel_slider)                                        | Affichage dynamique via carrousel.                     |

---

## 🚀 Démarrage rapide

1. **Clonez le dépôt :**

```bash
git clone https://github.com/votre-utilisateur/kyc_flutter_app.git
cd kyc_flutter_app
```

2. **Ajoutez les dépendances :**

```bash
flutter pub get
```

3. **Lancez l'application :**

```bash
flutter run
```

---

## 📷 Aperçu de l'application

| 🖼️ Écran 1                        | 🖼️ Écran 2                        | 🖼️ Écran 3                        |
| ---------------------------------- | ---------------------------------- | ---------------------------------- |
| ![](assets/images/onboarding1.png) | ![](assets/images/onboarding2.png) | ![](assets/images/onboarding3.png) |

---

## 📌 Remarques importantes

🛠️ L'écran d'onboarding s'affiche **uniquement lors du premier lancement**.

🖼️ Assurez-vous que les images soient bien placées dans le dossier `assets/images` et déclarées dans le fichier `pubspec.yaml` :

```yaml
flutter:
  assets:
    - assets/images/
```

---

## 👨‍💻 Auteur

**ABDELALI MOUTAWASSIT**
🔗 [GitHub]() • 🌐 [Portfolio]()

---
