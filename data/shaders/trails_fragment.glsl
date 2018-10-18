in vec4 color;
in vec2 texcoord;
uniform vec4 trailColor;
uniform float trailLength;
in float trailTime;
in float simTime;
out vec4 fragColor;
uniform float uv_fade;
uniform float alpha;

void main()
{
   fragColor = trailColor;
   float fadeFac = (simTime-trailTime)/trailLength;
   //if (fadeFac >1.0 ) {
   //  discard;
   //}
   fragColor.a=1.-fadeFac;
   if ((simTime-trailTime)>trailLength ||trailTime>simTime){
     discard;
   }
   fragColor.a*=uv_fade*alpha;  
}
