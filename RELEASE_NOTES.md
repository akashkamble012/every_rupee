# Release Notes: v1.0.0 (Every Rupee)

## 📖 Project Overview
Welcome to the first official release of **Every Rupee**! Every Rupee is a comprehensive zero-based budgeting application designed to give you absolute control over your personal finances. Following the philosophy that *every rupee needs a job before the month begins*, the app helps you effortlessly allocate your income, meticulously track your daily ledger, visualize your spending habits, and securely sync your financial roadmap to the cloud.

## 🌟 Core Features (v1.0.0)
* **Zero-Based Budget Setup:** A dedicated setup flow allowing you to assign every rupee of your net income to specific categories before the month even begins.
* **Offline-First with Cloud Sync:** Lightning-fast local storage via Isar Database, intelligently paired with Firebase Firestore for seamless, real-time secure cloud backups and cross-device syncing.
* **Interactive Dashboard:** 
  * *Overview:* A sticky math tracker keeping you informed of your Income, Allocated, and Unassigned funds at a glance.
  * *Charts:* Beautiful visual insights and trend graphs to analyze your spending habits.
  * *Roadmap:* Long-term financial planning tools with multi-month projections and temporary outflow management.
* **Robust Ledger System:** Easily add, edit, and categorize transactions. Features advanced filtering by date range, category, transaction type, and text search.
* **Biometric App Lock:** Optional security layer utilizing your device's fingerprint or face scan to protect your sensitive financial data.
* **Flexible Data Exports:** Share your ledger history effortlessly by exporting to CSV, Excel (.xlsx), or PDF document formats directly from the app.
* **Modern UI/UX:** Built with Flutter and Material 3, offering a premium feel with fluid micro-animations, swipeable tabs, and clean, clutter-free navigation.

## 🎨 UI & UX Highlights
* **Dashboard Overhaul:** Completely reorganized the main dashboard to reduce bottom-navigation clutter. The dashboard now features a sleek, swipeable three-tab layout:
  * **Overview:** A sticky math tracker showing net income, allocations, and unassigned funds at a glance.
  * **Charts:** A dedicated space for all your financial visualizations, pie charts, and trends.
  * **Roadmap:** Your long-term projection tables and outflow planners, neatly tucked into its own tab.
* **Improved Feedback:** Added clear SnackBar alerts and confirmation dialogs for critical actions like Syncing, Exporting, and Signing Out.

## 🛠 Under the Hood & Bug Fixes
* **Real-time State Syncing:** Fixed a major bug where data wouldn't refresh after a Firestore sync. The app now heavily utilizes Isar's `watchAll` streams, ensuring that new transactions or budget changes are instantly reflected in the UI without needing to switch tabs.
* **Codebase Cleanup:** Conducted a massive sweep of the codebase to resolve over 40 linting warnings, remove unused imports, and optimize `const` widget constructors for better performance.
* **Stable Database Queries:** Safely migrated away from experimental Isar `.getByIndex()` APIs to stable filtering patterns across all local data repositories.
* **Modernized Deprecations:** Upgraded deprecated Material 3 color APIs (replacing `.withOpacity` with `.withValues`) and modernized the file-sharing system to use the latest `share_plus` packages.
