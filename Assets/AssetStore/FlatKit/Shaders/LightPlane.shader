Shader "FlatKit/LightPlane" {
	Properties {
		[Header(Color alpha controls opacity)] [HDR] _Color ("Color", Vector) = (0.5,0.5,0.5,1)
		[Space(15)] _Depth ("Depth Fade Distance", Range(1, 500)) = 100
		[Space] _CameraDistanceFadeFar ("Camera Distance Fade Far", Float) = 10
		_CameraDistanceFadeClose ("Camera Distance Fade Close", Float) = 0
		[Space] _UvFadeX ("UV Fade X", Range(0, 10)) = 0.1
		_UvFadeY ("UV Fade Y", Range(0, 10)) = 0.1
		[ToggleOff] _AllowAlphaOverflow ("Allow Alpha Overflow", Float) = 0
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200

		Pass
		{
			HLSLPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			float4x4 unity_ObjectToWorld;
			float4x4 unity_MatrixVP;

			struct Vertex_Stage_Input
			{
				float4 pos : POSITION;
			};

			struct Vertex_Stage_Output
			{
				float4 pos : SV_POSITION;
			};

			Vertex_Stage_Output vert(Vertex_Stage_Input input)
			{
				Vertex_Stage_Output output;
				output.pos = mul(unity_MatrixVP, mul(unity_ObjectToWorld, input.pos));
				return output;
			}

			float4 _Color;

			float4 frag(Vertex_Stage_Output input) : SV_TARGET
			{
				return _Color; // RGBA
			}

			ENDHLSL
		}
	}
	Fallback "Diffuse"
}