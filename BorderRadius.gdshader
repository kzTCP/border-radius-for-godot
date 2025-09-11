shader_type canvas_item;

/* --- STRETCH SETTINGS --- */
uniform vec2 tex_size = vec2(512.0, 512.0); // original texture size in pixels
uniform vec2 rect_size = vec2(180.0, 90.0); // the rectangle size in pixels
uniform int stretch_mode : hint_range(0, 7, 1) = 0; // 0..7
uniform bool expand = true;  // only affects mode 0

/* --- BORDER RADIUS SETTINGS --- */
uniform float top = 0.0;
uniform float right = 0.0;
uniform float bottom = 0.0;
uniform float left = 0.0;

/* --- HELPERS --- */
vec2 get_uv(vec2 uv) {
    vec2 result_uv = uv;

    if (stretch_mode == 0) { // STRETCH_SCALE_ON_EXPAND
        if (expand) {
            result_uv = uv;
        } else {
            result_uv = (uv * rect_size) / tex_size;
        }
    }
    else if (stretch_mode == 1) { result_uv = uv; }
    else if (stretch_mode == 2) { result_uv = fract(uv * rect_size / tex_size); }
    else if (stretch_mode == 3) { result_uv = (uv * rect_size) / tex_size; }
    else if (stretch_mode == 4) { 
        vec2 offset = (rect_size - tex_size) * 0.5 / rect_size;
        result_uv = (uv - offset) * rect_size / tex_size;
    }
    else if (stretch_mode == 5) {
        float tex_aspect = tex_size.x / tex_size.y;
        float rect_aspect = rect_size.x / rect_size.y;
        vec2 scale = vec2(1.0);
        if (tex_aspect > rect_aspect) scale.y = rect_aspect / tex_aspect;
        else scale.x = tex_aspect / rect_aspect;
        result_uv = uv / scale;
    }
    else if (stretch_mode == 6) {
        float tex_aspect = tex_size.x / tex_size.y;
        float rect_aspect = rect_size.x / rect_size.y;
        vec2 scale = vec2(1.0);
        vec2 offset = vec2(0.0);
        if (tex_aspect > rect_aspect) { scale.y = rect_aspect / tex_aspect; offset.y = (1.0 - scale.y) * 0.5; }
        else { scale.x = tex_aspect / rect_aspect; offset.x = (1.0 - scale.x) * 0.5; }
        result_uv = (uv - offset) / scale;
    }
    else if (stretch_mode == 7) {
        float tex_aspect = tex_size.x / tex_size.y;
        float rect_aspect = rect_size.x / rect_size.y;
        vec2 scale = vec2(1.0);
        if (tex_aspect > rect_aspect) scale.x = tex_aspect / rect_aspect;
        else scale.y = rect_aspect / tex_aspect;
        result_uv = uv / scale + (scale - vec2(1.0)) * 0.5 / scale;
    }

    return result_uv;
}

/* --- BORDER RADIUS HELPERS --- */
bool isOut(float x, float y, float radius) {
    return (x * x + y * y) > (radius * radius);
}

bool checkCorner(vec2 uv, float radius, vec2 corner_pos, bool flip_x, bool flip_y) {
    if (radius <= 0.0) return false;
    vec2 pos = uv * rect_size;
    if ((flip_x ? pos.x > corner_pos.x : pos.x < corner_pos.x) &&
        (flip_y ? pos.y > corner_pos.y : pos.y < corner_pos.y)) {
        vec2 dist = pos - corner_pos;
        return isOut(dist.x, dist.y, radius);
    }
    return false;
}

void fragment() {
    vec2 uv = get_uv(UV);

    // --- SKIP PIXELS OUTSIDE ORIGINAL TEXTURE (KEEP MODES) ---
    bool skip = false;
    if (stretch_mode == 3 || stretch_mode == 4 || stretch_mode == 5 || stretch_mode == 6) {
        if (uv.x < 0.0 || uv.y < 0.0 || uv.x > 1.0 || uv.y > 1.0) {
            COLOR = vec4(0.0);
            skip = true;
        }
    }

    if(!skip) {
        // --- BORDER-RADIUS CLIPPING ---
        bool discard_pixel =
            checkCorner(UV, top, vec2(top, top), false, false) ||           // Top-left
            checkCorner(UV, right, vec2(rect_size.x - right, right), true, false) || // Top-right
            checkCorner(UV, bottom, vec2(rect_size.x - bottom, rect_size.y - bottom), true, true) || // Bottom-right
            checkCorner(UV, left, vec2(left, rect_size.y - left), false, true);       // Bottom-left

        if (discard_pixel) COLOR.a = 0.0;
        else COLOR = texture(TEXTURE, uv);
    }
}
