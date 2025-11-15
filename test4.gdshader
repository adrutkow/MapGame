shader_type spatial;
render_mode blend_mix, unshaded, cull_disabled;

uniform sampler2D albedo_texture; // set from GDScript or inspector
uniform float thickness : hint_range(1.0, 16.0, 0.1) = 3.0;
uniform vec4 _Color : source_color = vec4(0.0, 1.0, 0.0, 1.0);



void fragment() {
    vec4 color = texture(albedo_texture, UV);
    
    // remove black pixels
    if (color.r == 0.0 && color.g == 0.0 && color.b == 0.0) {
        // check neighbors for outline
        bool neighbor_nonblack = false;
        
        // sample 8 neighbors in UV space
        for (int x=-1; x<=1; x++) {
            for (int y=-1; y<=1; y++) {
                if (x==0 && y==0) continue;
                vec2 offset = vec2(float(x), float(y)) * thickness;
                vec4 sample = texture(albedo_texture, UV + offset);
                if (sample.r != 0.0 || sample.g != 0.0 || sample.b != 0.0) {
                    neighbor_nonblack = true;
                }
            }
        }
        
        if (neighbor_nonblack) {
            ALBEDO = vec3(1.0, 0.0, 0.0);
            ALPHA = 1.0;
            discard;
        } else {
            discard;
        }
    }

    // normal sprite color (replace with your desired color)
    ALBEDO = vec3(0.0, 1.0, 0.0); // green
    ALPHA = 1.0;
}