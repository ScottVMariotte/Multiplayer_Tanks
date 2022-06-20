//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 u_v_rgb;

void main()
{
	vec4 color = texture2D( gm_BaseTexture, v_vTexcoord );
	vec3 color_mix = vec3(color) * u_v_rgb;
	
	gl_FragColor = vec4(color_mix, color[3]);
}
