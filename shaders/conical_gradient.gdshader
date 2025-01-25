shader_type canvas_item;

uniform vec4 color1 : source_color; // Start color
uniform vec4 color2 : source_color; // End color

void fragment() {
    // Calculate normalized UV coordinates
    vec2 uv = UV * 2.0 - vec2(1.0);

    // Compute the angle of the current pixel from the center
    float angle = atan(uv.y, uv.x);

    // Normalize the angle to a range of 0.0 to 1.0
    float normalized_angle = (angle + 3.14159265359) / (2.0 * 3.14159265359);

    // Determine gradient zones
    if (normalized_angle < 0.25) {
        // First 25% of the circle: Fully color1
        COLOR = color1;
    } else if (normalized_angle < 0.75) {
        // Middle 50% of the circle: Transition
        float t = (normalized_angle - 0.25) / 0.5; // Map to 0.0 - 1.0
        COLOR = mix(color1, color2, t);
    } else {
        // Final 25% of the circle: Fully color2
        COLOR = color2;
    }
}
