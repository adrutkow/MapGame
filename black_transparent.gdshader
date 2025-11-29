shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled;

uniform sampler2D albedo_texture;  // must be set from GDScript or inspector
uniform vec3 c : source_color = vec3(0.0, 1.0, 0.0);



void fragment() {
    vec4 color = texture(albedo_texture, UV);
    if (color.r == 0.0 && color.g == 0.0 && color.b == 0.0) {
        discard;
    }
    ALBEDO = c;
    ALPHA = 0.3;
}
