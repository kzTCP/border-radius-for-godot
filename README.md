# Border-Radius (Corner-Radius) for Images in Godot

This guide explains how to apply rounded corners (**corner-radius / border-radius**) to images using a `TextureRect` shader in **Godot**, and how to align them with a parent `Panel`.

---

## 📸 Showcase

| TextureRect only | Panel + TextureRect |
|----------------|---------------------------|
| ![Showcase 1](https://godotshaders.com/wp-content/uploads/2025/09/img-1.png) | ![Showcase 2](https://godotshaders.com/wp-content/uploads/2025/09/img-2.png) |

---

## 🎥 Demo Video
[![My Video Showcase](https://img.youtube.com/vi/UM1I97-V_I8/0.jpg)](https://www.youtube.com/watch?v=UM1I97-V_I8)

▶️ *Version 1.0.0 - Border-radius customization demo*

[![My Video Showcase](https://img.youtube.com/vi/68dlosOz77w/0.jpg)](https://www.youtube.com/watch?v=68dlosOz77w)

▶️ *Version 1.0.1 - Background color, stretch-mode and resize demo*

[![My Video Showcase](https://img.youtube.com/vi/VN7V5UQ0Ri4/0.jpg)](https://www.youtube.com/watch?v=VN7V5UQ0Ri4)

▶️ *NEW: Version 1.0.2 - Font color customization demo*

## 🎯 Overview

- **v1.0.0**
  - Use a `Panel` as parent and a `TextureRect` with shader as child.  
  - Match **corner-radius** values between the two.  
- **v1.0.1**
  - Adjust size values if alignment looks off.  
  - Supports **stretch modes 0..7** (same as `TextureRect` in Godot).
  - Resize toggle to enable/disable content resizing
  - Resized Shape alignment options (9 positions)
  - Fill color for empty/transparent areas
- **NEW**
  - Foreground color customization for icon tinting
  - Foreground alpha control for mixing between `bg` and `fg` `colors`

---

## ⚠️ Notes

- Always keep the `TextureRect` and `Panel` the same size.  
- If corners do not align perfectly, tweak the shader size slightly.  
- **Stretch Modes:**
  - Matches Godot’s built-in behavior.
  - `0..7` modes are supported (`hint_range`).
  - `expand` only affects **mode 0**.
  - Modes **3 and 4** won’t expand beyond `rect_size` (not like `TextureRect`).
- Corners apply only within the **available pixels** in `rect_size`.
- Copy **`BorderRadius.gdshader`** file into your project.  

---

## 📐 Texture Size vs Rect Size

It’s important to understand the difference between these two parameters:

- `tex_size` → The **original texture’s resolution** in pixels (e.g., `512x512`).

  - This is the **raw size** of the image you load into the shader.

  - Does **not** change when you resize the `TextureRect` node.

- `rect_size` → The **display size** of the `TextureRect` in the scene (e.g., `180x90`).

  - This is the area where the texture is drawn, after stretching or scaling.

  - Affected by `stretch_mode` and the node’s layout size.

👉 Example:

- If you load a `512x512` image into a `TextureRect` that is only `180x90` in the scene:
  - `tex_size = vec2(512, 512)`
  - `rect_size = vec2(180, 90)`

- The shader uses both values to calculate how the image should be mapped and **where the corner-radius should cut pixels.**

## 🆕 Enhanced Features

### Alignment Options (9 Positions)

Control where your content appears within the rectangle:

- `0`: Top Left
- `1`: Top Center
- `2`: Top Right
- `3`: Center Left
- `4`: Center (default)
- `5`: Center Right
- `6`: Bottom Left
- `7`: Bottom Center
- `8`: Bottom Right

⚠️ Important: Alignment only works when `use_resize` is enabled!

## Fill Options (NEW)

Tint your icons/images with custom colors:

- `use_fill`: Toggle fill color on/off
- `bg_color`: Replace transparent/empty areas with a custom color
- **`fg_color`**: A color value used for tinting the image. By default, the alpha in the `vec4` is set to **0**, so it does not affect the current icon’s color. If you increase the alpha above **0**, the tint is applied
- `fg_alpha`: Control mixing between background and foreground colors

Perfect for creating `icon buttons` with consistent color schemes!

## Resize Toggle

`use_resize`: Enable/disable the resizing functionality. When enabled, applies:

- alignment
- size adjustments

## 🔗 Resources

- 🎨 Godotshaders: [Corner-Radius Shader](https://godotshaders.com/shader/corner-radius/)  
- 🖼 Godotshaders: [Set Corner Radius for Texture](https://godotshaders.com/shader/set-corner-radius-for-texture/)  
- 📘 Godot Docs: [Your First 2D Shader](https://docs.godotengine.org/en/3.6/tutorials/shaders/your_first_shader/your_first_2d_shader.html)  
- 🎥 YouTube: [Godot Shaders: An Introduction (YouTube)](https://www.youtube.com/watch?v=JM09avtMlmE)  
- 🤖 Border radius  by [DeepSeek](https://chat.deepseek.com/)
- 🤖 Stretch mode by [ChatGPT](https://chat.openai.com/)  
- 🤖 V1.0.1 features collaboration between both AI systems
- 🤖 V1.0.2 features by `DeepSeek`

---

## ✅ Summary

By syncing the **Panel corner radius** with the **TextureRect shader radius**, you get perfectly rounded corners for images in **Godot**.

Now with **stretch modes 0..7**, the shader works like `TextureRect` while preserving corner-radius clipping.

And remember: `tex_size` **is the raw image resolution**, `rect_size` **is the final drawn size** — the shader needs both to properly stretch and cut corners.
