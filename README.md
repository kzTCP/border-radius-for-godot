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
▶️ *Click to watch my full demo on YouTube.*

---

## 🎯 Overview
- Use a `Panel` as parent and a `TextureRect` with shader as child.  
- Match **corner-radius** values between the two.  
- Adjust size values if alignment looks off.  

---

## ⚠️ Notes
- Always keep the `TextureRect` and `Panel` the same size.  
- If corners do not align perfectly, tweak the shader size slightly.  
- Copy **`BorderRadius.gdshader`** file into your project.  

---

## 🔗 Resources (Must Be Included)

- 🎨 Godotshaders: [Corner-Radius Shader](https://godotshaders.com/shader/corner-radius/)  
- 🖼 Godotshaders: [Set Corner Radius for Texture](https://godotshaders.com/shader/set-corner-radius-for-texture/)  
- 📘 Godot Docs: [Your First 2D Shader](https://docs.godotengine.org/en/3.6/tutorials/shaders/your_first_shader/your_first_2d_shader.html)  
- 🎥 YouTube: [Godot Shaders: An Introduction](https://www.youtube.com/watch?v=JM09avtMlmE)  
- 🤖 The Best Ai: [DeepSeek](https://chat.deepseek.com/)  

---

## ✅ Summary
By syncing the **Panel corner radius** with the **TextureRect shader radius**, you get perfectly rounded corners for images in **Godot**.
