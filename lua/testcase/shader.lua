local basic = require "shader.basic"

return lovr.graphics.newShader([[

	out vec4 spacePosition;
	vec4 position(mat4 projection, mat4 transform, vec4 vertex) {
	  spacePosition = lovrModel * vertex;
	  return projection * transform * vertex;
	}

]],[[

	in vec4 spacePosition;
	vec4 color(vec4 graphicsColor, sampler2D image, vec2 uv) {
		vec3 pos = spacePosition.xyz/spacePosition.w;
		if (mod(pos.x + pos.y + pos.z + 34.0, 0.5) > 0.1)
			discard; 
		return graphicsColor;
	}

]])
