Shader "Custom/ScrollingUV"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}
        _ScrollSpeedX ("Scroll Speed X", Float) = 0.35
        _ScrollSpeedY ("Scroll Speed Y", Float) = 0.35
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D(_Texture);
            SAMPLER(sampler_Texture);

            CBUFFER_START(UnityPerMaterial)
                float4 _Texture_ST;
                float _ScrollSpeedX;
                float _ScrollSpeedY;
            CBUFFER_END

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = TRANSFORM_TEX(IN.uv, _Texture);
                OUT.uv.x += _ScrollSpeedX * _Time.y;
                OUT.uv.y += _ScrollSpeedY * _Time.y;
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 col = SAMPLE_TEXTURE2D(_Texture, sampler_Texture, IN.uv);
                return col;
            }
            ENDHLSL
        }
    }
}