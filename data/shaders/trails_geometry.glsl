layout(triangles) in;
layout(triangle_strip, max_vertices = 4) out;
uniform mat4 uv_viewProjectionMatrix;
uniform mat4 uv_modelViewProjectionMatrix;
uniform mat4 uv_modelMatrix;
uniform mat4 uv_viewMatrix;
uniform mat4 uv_projectionMatrix;
uniform mat4 uv_modelViewMatrix;
uniform float trailWidth;
uniform float trailLength;
uniform float uv_simulationtimeSeconds;
out vec4 color;
out vec2 texcoord;
out float trailTime;
out float simTime;

void drawLine(vec4 position0, vec4 position1, float time1, float time2, float width)
{
    vec3 viewPosition0 = (uv_viewMatrix * uv_modelMatrix * position0).xyz;
    vec3 viewPosition1 = (uv_viewMatrix * uv_modelMatrix * position1).xyz;
    vec3 side = normalize(cross(viewPosition0, viewPosition1 - viewPosition0)) * width;
    gl_Position = uv_projectionMatrix  *vec4(viewPosition0 - side,1);
    texcoord = vec2(0, 0);
	trailTime=time1;
    EmitVertex();
    gl_Position =  uv_projectionMatrix * vec4(viewPosition0 + side,1);
    texcoord = vec2(0,1);
	trailTime=time1;
    EmitVertex();
    gl_Position = uv_projectionMatrix *vec4(viewPosition1 - side, 1);
    texcoord = vec2(1,0);
	trailTime=time2;
    EmitVertex();
    gl_Position = uv_projectionMatrix *vec4(viewPosition1 + side, 1);
    texcoord = vec2(1,1);
	trailTime=time2;
    EmitVertex();
    EndPrimitive();
}

void main()
{
	vec3 pos1 = 1000.*vec3(-gl_in[0].gl_Position.x-8.3,-gl_in[0].gl_Position.y,gl_in[0].gl_Position.z);
	vec3 pos2 = 1000.*vec3(-gl_in[1].gl_Position.x-8.3,-gl_in[1].gl_Position.y,gl_in[1].gl_Position.z);
	float time1=gl_in[2].gl_Position.x;
	float time2=gl_in[2].gl_Position.y;
	simTime = 1000.*(fract(uv_simulationtimeSeconds/60.)-1.);
	color = vec4(1.);
	if (true ){
		drawLine(vec4(pos1,1), vec4(pos2,1),time1,time2,trailWidth);
	}
}
