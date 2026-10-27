# Godot Physics Simulations

A collection of small real-time physics and cellular-automata simulations written in **GDScript** for **Godot 3.x**.
Built in **2023** (spring semester, March–May) during the *Real-time Physics Simulation Programming* course (Game Development, Jagiellonian University).

Each folder is a standalone Godot project. The physics is implemented by hand (integration, forces, collision response, automata rules) instead of relying on Godot's built-in physics engine.

| Simulation | Topic | Technique |
|---|---|---|
| [Spring pendulum](#spring-pendulum) | Mechanics | Hooke's law, explicit Euler integration |
| [Spring rope](#spring-rope) | Mass-spring systems | Mass-spring chain, symplectic Euler, damping |
| [Ball collision](#ball-collision) | Rigid body collisions | Impulse-based response, coefficient of restitution |
| [Boids](#boids) | Flocking / steering | Alignment, cohesion, separation |
| [Game of Life](#game-of-life) | Cellular automata | Conway's rules on a TileMap grid |
| [Falling sand & water](#falling-sand--water) | Cellular automata | Sand/water automaton with lateral spreading |
| [Fire](#fire) | Particle systems | Particle emitter with lifetime, shrink and colour fade |

---

## Spring pendulum
`spring-pendulum/` · main scene: `wahadlo3D.tscn` (2D version: `Node2D.tscn`)

<!-- ![Spring pendulum](docs/gifs/spring-pendulum.gif) -->
<p>
  <img src="docs/screenshots/spring-pendulum-3d-1.png" width="32%" alt="Spring pendulum 3D, t = 0.4 s">
  <img src="docs/screenshots/spring-pendulum-3d-2.png" width="32%" alt="Spring pendulum 3D, t = 1.2 s">
  <img src="docs/screenshots/spring-pendulum-2d-3.png" width="32%" alt="Spring pendulum 2D">
</p>

A mass hanging on a spring from a fixed anchor point. Each physics frame the spring force `F = k · (L₀ − |x − S|)` along the spring direction is combined with gravity and integrated with explicit Euler. The spring is drawn as a line between the anchor and the mass.

## Spring rope
`spring-rope/` · main scene: `main.tscn`

<!-- ![Spring rope](docs/gifs/spring-rope.gif) -->
<p>
  <img src="docs/screenshots/spring-rope-1.png" width="32%" alt="Spring rope being dragged">
  <img src="docs/screenshots/spring-rope-2.png" width="32%" alt="Spring rope swinging after release">
  <img src="docs/screenshots/spring-rope-3.png" width="32%" alt="Spring rope falling back">
</p>

A rope made of 15 point masses linked by springs, with the top node pinned. Springs act only when stretched (like a real rope), velocity-proportional damping keeps it stable, and positions are integrated with **symplectic Euler** (forces for all nodes are computed first, then all nodes are advanced).

**Controls:** click and drag any node with the mouse.

## Ball collision
`ball-collision/` · main scene: `Spatial.tscn`

<!-- ![Ball collision](docs/gifs/ball-collision.gif) -->
<p>
  <img src="docs/screenshots/ball-collision-1.png" width="32%" alt="Balls approaching">
  <img src="docs/screenshots/ball-collision-2.png" width="32%" alt="Balls at the moment of collision">
  <img src="docs/screenshots/ball-collision-3.png" width="32%" alt="Balls moving apart after an oblique collision">
</p>

Two spheres with configurable mass and velocity. On contact the collision normal is computed and an impulse `J = μ · (1 + e) · Δv⊥` (with reduced mass `μ`) is applied to both bodies, so the coefficient of restitution `e` controls how elastic the collision is.

## Boids
`boids/` · main scene: `main.tscn`

<!-- ![Boids](docs/gifs/boids.gif) -->
<p>
  <img src="docs/screenshots/boids-1.png" width="32%" alt="Boids at start, randomly scattered">
  <img src="docs/screenshots/boids-2.png" width="32%" alt="Boids forming a flock">
  <img src="docs/screenshots/boids-3.png" width="32%" alt="Flock moving along the wall">
</p>

Craig Reynolds' flocking model with 80 agents. Each boid tracks its neighbours using an `Area2D` and combines three steering rules with tunable weights:
- **alignment** – match the average heading of neighbours,
- **cohesion** – steer towards their centre of mass,
- **separation** – push away from boids that are too close.

Collisions with the level walls (`TileMap`) reflect the boid away from the wall.

**Controls:** left click to spawn a new boid.

## Game of Life
`game-of-life/` · main scene: `main.tscn`

<!-- ![Game of Life](docs/gifs/game-of-life.gif) -->
<p>
  <img src="docs/screenshots/game-of-life-1.png" width="32%" alt="Game of Life, initial pattern">
  <img src="docs/screenshots/game-of-life-2.png" width="32%" alt="Game of Life after a few generations">
  <img src="docs/screenshots/game-of-life-3.png" width="32%" alt="Game of Life, later generation">
</p>

Conway's Game of Life on a 64×36 grid. The starting pattern is read from the cells painted in the `TileMap` in the editor, then the grid is updated with a double buffer so every cell is evaluated against the same generation.

## Falling sand & water
`falling-sand/` · main scene: `main.tscn`

<!-- ![Falling sand and water](docs/gifs/falling-sand.gif) -->
<p>
  <img src="docs/screenshots/falling-sand-1.png" width="32%" alt="Sand pile and spreading water">
  <img src="docs/screenshots/falling-sand-2.png" width="32%" alt="Sand poured into water">
  <img src="docs/screenshots/falling-sand-3.png" width="32%" alt="Settled sand and water">
</p>

A 128×64 cellular automaton with two materials:
- **sand** falls down, slides diagonally off piles and displaces water,
- **water** falls down and spreads sideways to the nearest free cell, choosing a random side when both are free.

**Controls:** hold the left mouse button to paint water, the right mouse button to paint sand.

## Fire
`fire/` · main scene: `main3D.tscn` (2D version: `main2D.tscn`)

<!-- ![Fire](docs/gifs/fire.gif) -->
<p>
  <img src="docs/screenshots/fire-3d-1.png" width="48%" alt="Fire particle system, 3D">
  <img src="docs/screenshots/fire-2d-1.png" width="48%" alt="Fire particle system, 2D">
</p>

A simple hand-made particle system. An emitter spawns particles with a random horizontal velocity and spin; each particle rises, shrinks and fades from yellow to red over a 2-second lifetime before being freed.

---

## Running
1. Install [Godot 3.x](https://godotengine.org/download/archive/) (standard build, not Godot 4: the projects use the Godot 3 API).
2. In the Project Manager choose **Import** and select the `project.godot` file of the simulation you want to run.
3. Press **F5** to run the main scene.

## Tech
Godot 3 · GDScript · numerical integration (explicit and symplectic Euler) · mass-spring systems · impulse-based collisions · cellular automata · steering behaviours
