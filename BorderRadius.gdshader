shader_type canvas_item;

uniform vec2 size 		= vec2(90.0, 90.0);
uniform float top 		= 0.0;
uniform float right 	= 0.0;
uniform float bottom 	= 0.0;
uniform float left 		= 0.0;

bool isOut(float x, float y, float corner_scale) {
    // Optimized circle distance check
    return (x * x + y * y) > (corner_scale * corner_scale);
}

bool isTopLeft(vec2 uv, float radius) {
    if (radius <= 0.0) return false;
    vec2 corner_pos = vec2(radius, radius);
    vec2 dist = uv * size - corner_pos;
    return all(lessThan(uv * size, corner_pos)) && isOut(dist.x, dist.y, radius);
}

bool isTopRight(vec2 uv, float radius) {
    if (radius <= 0.0) return false;
    vec2 corner_pos = vec2(size.x - radius, radius);
    vec2 dist = uv * size - corner_pos;
    return (uv.x * size.x > corner_pos.x && uv.y * size.y < corner_pos.y) && isOut(dist.x, dist.y, radius);
}

bool isBottomRight(vec2 uv, float radius) {
    if (radius <= 0.0) return false;
    vec2 corner_pos = vec2(size.x - radius, size.y - radius);
    vec2 dist = uv * size - corner_pos;
    return all(greaterThan(uv * size, corner_pos)) && isOut(dist.x, dist.y, radius);
}

bool isBottomLeft(vec2 uv, float radius) {
    if (radius <= 0.0) return false;
    vec2 corner_pos = vec2(radius, size.y - radius);
    vec2 dist = uv * size - corner_pos;
    return (uv.x * size.x < corner_pos.x && uv.y * size.y > corner_pos.y) && isOut(dist.x, dist.y, radius);
}

void fragment() {
    // Convert UV coordinates to pixel coordinates
    vec2 pixel_uv = UV * size;
    
    // Check each corner with individual radius values
    bool discard_pixel = 
        isTopLeft(UV, top) || 
        isTopRight(UV, right) || 
        isBottomRight(UV, bottom) || 
        isBottomLeft(UV, left);
    
    if (discard_pixel) {
        COLOR.a = 0.0;
    } else {
        COLOR = texture(TEXTURE, UV);
    }
	
}
