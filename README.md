# Virtual Steering Addon for Godot

A powerful and easy-to-use virtual steering addon for Godot Engine, designed to integrate seamlessly with both 2D and 3D projects. Fully customizable with options for sensitivity, rotation limits, custom textures, and horn sounds. Compatible with Godot 4.x up to 4.3.

## Features
- **TextureRect Node-Based Steering**: Ensures your steering wheel integrates perfectly into your UI layout.
- **Sensitivity Control**: Adjust the steering sensitivity to match your game mechanics.
- **Rotation Limits**: Set maximum rotation angles for both handle visuals and steering logic.
- **2D and 3D Contexts**: Easy to implement in any type of project.
- **Horn Feature**: Includes a customizable horn sound.
- **Customizable Textures and Sounds**: Assign your own handle texture and horn audio stream.
- **Default Assets**: Comes with a default handle texture and horn sound assigned.
- **Godot Compatibility**: Supports Godot versions 4.0 to 4.3.

---

## How to Use

1. **Download the Addon**:
   - Go to the [Releases](#) section and download the latest version.
   
2. **Install the Addon**:
   - Paste the `addons` folder into your project's root directory.
   - Enable the plugin in **Project Settings > Plugins**.

3. **Add the Node**:
   - Add a `VirtualSteering` node to your vehicle scene.

4. **Configure the Addon**:
   - Assign your custom handle texture and horn audio stream directly in the node's property section (optional).

5. **Get Steering Angle**:
   - Use the `VirtualSteering.get_steering()` function to retrieve the steering angle in radians.

---

## Things to Keep in Mind

- **Horn Feature**: 
  - Ensure the `horn_enabled` option is set to `true` before using the horn, or it won't play.
  
- **Rotation Limits**:
  - Understand the difference between `handle_rotation_limit` and `steering_rotation_limit`:
    - `handle_rotation_limit`: Maximum visual rotation angle of the handle in degrees.
    - `steering_rotation_limit`: Maximum steering angle returned by the `get_steering()` function based on handle rotation (in degrees).

- **Handle Return Speed**:
  - `handle_return_speed` is used for changing the handle return speed when it is released.

---
