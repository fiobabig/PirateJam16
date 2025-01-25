shader_type canvas_item;

uniform sampler2D dark_texture : source_color;
uniform float texture_mix_amount : hint_range(0.0, 1.0);

uniform sampler2D dissolve_texture : source_color;
uniform float dissolve_value : hint_range(0.0, 1.0);

uniform float shadow_outline_width = 2.0;
uniform vec4 shadow_outline_color : source_color;

uniform float bond_outline_width = 2.0;
uniform vec4 bond_outline_color : source_color;

uniform float glow_radius = 5.0;
uniform float glow_amount = 0.25;

vec4 combine(vec4 current, vec2 uv) {
	vec4 tex_b = texture(dark_texture, uv);
    
    current = mix(current, tex_b, 1.0 - texture_mix_amount);	
	
	return current;
}

vec4 dissolve(vec4 current, vec2 uv) {
	vec4 noise_texture = texture(dissolve_texture, uv);
    current.a *= floor(dissolve_value + min(1, noise_texture.x));
	
	return current;
}

vec4 outline(vec4 current, sampler2D tex, vec2 uv, vec2 texture_pixel_size, float outline_width, vec4 outline_color) {
	vec2 ps = texture_pixel_size;
	float a;
	float maxa = current.a;
	float mina = current.a;

	a = texture(tex, uv + vec2(0.0, -outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(tex, uv + vec2(0.0, outline_width) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(tex, uv + vec2(-outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	a = texture(tex, uv + vec2(outline_width, 0.0) * ps).a;
	maxa = max(a, maxa);
	mina = min(a, mina);

	return mix(current, outline_color, maxa - mina);
}

vec4 glow(vec4 current, sampler2D tex, vec2 uv, vec2 texture_pixel_size) {
	float r = glow_radius;
	vec2 ps = texture_pixel_size;
	vec4 glow = current;

	glow += texture(tex, uv + vec2(-r, -r) * ps);
	glow += texture(tex, uv + vec2(-r, 0.0) * ps);
	glow += texture(tex, uv + vec2(-r, r) * ps);
	glow += texture(tex, uv + vec2(0.0, -r) * ps);
	glow += texture(tex, uv + vec2(0.0, r) * ps);
	glow += texture(tex, uv + vec2(r, -r) * ps);
	glow += texture(tex, uv + vec2(r, 0.0) * ps);
	glow += texture(tex, uv + vec2(r, r) * ps);

	r *= 2.0;
	glow += texture(tex, uv + vec2(-r, -r) * ps);
	glow += texture(tex, uv + vec2(-r, 0.0) * ps);
	glow += texture(tex, uv + vec2(-r, r) * ps);
	glow += texture(tex, uv + vec2(0.0, -r) * ps);
	glow += texture(tex, uv + vec2(0.0, r) * ps);
	glow += texture(tex, uv + vec2(r, -r) * ps);
	glow += texture(tex, uv + vec2(r, 0.0) * ps);
	glow += texture(tex, uv + vec2(r, r) * ps);

	glow /= 17.0;
	glow *= glow_amount;
	current.rgb *= current.a;

	return glow + current;
}

void fragment() {
	vec4 result = texture(TEXTURE, UV);
	
	result = combine(result, UV);	
	result = dissolve(result, UV);
	result = outline(result, TEXTURE, UV, TEXTURE_PIXEL_SIZE, shadow_outline_width, shadow_outline_color);
	result = outline(result, TEXTURE, UV, TEXTURE_PIXEL_SIZE, bond_outline_width, bond_outline_color);
	//result = glow(result, TEXTURE, UV, TEXTURE_PIXEL_SIZE);
    
    COLOR = result;
}