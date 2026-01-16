# 🥭 Crash Bandicoot: Godot 4 Prototype

A technical study recreating the gameplay mechanics and "game feel" of the PS1 classic using **Godot 4.4**.
This project focuses on **Character Kinematics**, **Animation Blending**, and **State Machine Patterns**.

![CrashActualStatusIII](https://github.com/user-attachments/assets/c7d703b9-c4cf-4991-bc3b-f941d31ffebd)

## 📖 About the Project

The goal of this prototype was to reverse-engineer the specific platforming physics of *Crash Bandicoot*, translating legacy mechanics into a modern engine workflow. It serves as a playground for advanced **3D Animation control** and **Object-Oriented Programming**.

## ⚙️ Engineering & Architecture

### 🧠 Finite State Machine (FSM)
Implemented a robust **State Pattern** to manage character logic, preventing "spaghetti code" and ensuring clean transitions.
* **States Implemented:** `Idle`, `Run`, `Spin Attack`, `Dash`, `Jump`, `Fall`, `Damage`.
* **Logic:** Each state handles its own input and physics processing, making the controller modular and easy to debug.

### 🎭 Animation Systems (BlendTrees)
Instead of simple animation playback, I utilized Godot's **AnimationTree** and **BlendSpaces**.
* **Smooth Transitions:** Logic to interpolate between `Idle`, `Walk`, and `Run` animations based on input velocity.
* **Layered Animation:** Allows interactions (like taking damage or spinning) to override movement without snapping.

### 📦 Polymorphic Crate System
Designed a modular interaction system using **Inheritance (OOP)** for the iconic crates:
* **`BaseCrate` Class:** Handles generic health, destruction logic, and fruit spawning.
* **Derived Classes:**
    * `TNTCrate`: Initiates countdown logic upon collision.
    * `NitroCrate`: Triggers instant Area-of-Effect (AoE) damage.
    * `ItemCrate`: Spawns specific power-ups (Aku-Aku) or Wumpa Fruits.

### 🍎 UI & Collectibles
* **Dynamic UI:** Animated counters that react to gameplay events (Wumpa collection).
* **Inventory System:** Logic to track lives and power-up states (Aku-Aku masks).

---

## 🛠️ Tools Used
* **Engine:** Godot 4.4
* **Language:** GDScript
* **Patterns:** State Machine, Composition, Inheritance.

---

## 🎨 Credits & Assets

This is an educational project. All rights to Crash Bandicoot belong to Activision.

* **3D Model & Rig:** [MatiasH290 (Sketchfab)](https://sketchfab.com/3d-models/crash-bandicoot-442556bf988345afbbdc1f398c169a30)
* **Wumpa Fruit:** [Wersaus33 (Sketchfab)](https://sketchfab.com/3d-models/wumpa-fruit-crash-bandicoot-ps1-692e51b5c74743cca25ace41f11cd765)
* **Programming:** Matheus Soares ([@MrVeGGi3](https://github.com/MrVeGGi3))
