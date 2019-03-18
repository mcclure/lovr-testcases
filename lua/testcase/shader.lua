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
		return graphicsColor;
	}

]])
