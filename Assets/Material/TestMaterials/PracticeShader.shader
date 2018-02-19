Shader "Custom/PracticeShader"
{
	//Two simple properties (Color, Texture, Normal)
	Properties
	{
		//_Color
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Bumpmap", 2D) = "bump" {}
	}

	//Define the first and default subshader
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

		CGPROGRAM

		#pragma surface surf Lambert

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			//float4 color : COLOR;
		};

		sampler2D _MainTex;
		sampler2D _BumpMap;

		void surf (Input IN, inout SurfaceOutput o)
		{
			//o.Albedo = 1;
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
			o.Normal = UnpackNormal (tex2D (_BumpMap, In.uv_BumpMap));
		}

		ENDCG
	}
	Fallback "Diffuse"
}
