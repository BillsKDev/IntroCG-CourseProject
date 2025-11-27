Shader "Custom/UpdatedWater"
{
    Properties
    {
        _MainTex ("Water Texture", 2D) = "white" {}
        _FoamTex ("Foam Texture", 2D) = "white" {}
        [MaterialToggle] _UseTexture ("UseTexture", Float) = 0
        _FoamColor ("Foam Color", Color) = (0,0,0,1) 
        _FoamMag ("Foam Height", Range(-0.1,0.1)) = 0
        _FoamOpac ("Foam Threshold", Range(0,1)) = 0

        _PointX("PointX", Range(-1, 1)) = 0
        _PointY("PointY", Range(-1, 1)) = 0
        
        _Amplitude ("Amplitude", Float) = 0.5
        _Frequency ("Frequency", Float) = 1.0
        _Speed ("Speed", Float) = 1.0

        _ScrollX ("ScrollX", Range(-5,5)) = 1
        _ScrollY ("ScrollY", Range(-5,5)) = 1
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

            CBUFFER_START(UnityPerMaterial)
                float _Amplitude;
                float _Frequency;
                float _Speed;
                float _PointX;
                float _PointY;
                float _ScrollX;
                float _ScrollY;
                float _UseTexture;
            CBUFFER_END

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            
            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;  
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float distance : TEXCOORD1;
            };

            Varyings vert(Attributes input)
            {
                Varyings output;

                float2 Origin = float2(_PointX, _PointY);  
                float2 relativeToOrigin = input.uv * 2.0 - 1.0;  
                float2 diff = relativeToOrigin - Origin;
                float distance = sqrt(dot(diff, diff));
                
                float waveHeight = sin(distance * _Frequency + _Time.y * _Speed) * _Amplitude;
                input.positionOS.y += waveHeight;

                output.positionHCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = input.uv;
                output.distance = distance;

                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {
                float scrollTimeX = _ScrollX * _Time.y;
                float scrollTimeY = _ScrollY * _Time.y;
                
                half4 water;
                if (_UseTexture)
                    water = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, input.uv + float2(scrollTimeX, scrollTimeY));
                else
                    water = half4(0, 0, 1, 1);
                    
                return water;
            }
            ENDHLSL
        }

        Pass
        {
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha
            ColorMask RGB
            
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            CBUFFER_START(UnityPerMaterial)
                float _Amplitude;
                float _Frequency;
                float _Speed;
                float _PointX;
                float _PointY;
                float _ScrollX;
                float _ScrollY;
                float _UseTexture;
                float4 _FoamColor;
                float _FoamMag;
                float _FoamOpac;
            CBUFFER_END

            TEXTURE2D(_FoamTex);
            SAMPLER(sampler_FoamTex);

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;  
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float distance : TEXCOORD1;
                float highIncrease : TEXCOORD2;
            };

            Varyings vert(Attributes input)
            {
                Varyings output;

                float2 Origin = float2(_PointX, _PointY);  
                float2 relativeToOrigin = input.uv * 2.0 - 1.0;  
                float2 diff = relativeToOrigin - Origin;
                float distance = sqrt(dot(diff, diff));
                
                float waveHeight = sin(distance * _Frequency + _Time.y * _Speed) * _Amplitude;
                output.highIncrease = waveHeight + _FoamMag;
                input.positionOS.y += output.highIncrease;

                output.positionHCS = TransformObjectToHClip(input.positionOS.xyz);
                output.uv = input.uv;
                output.distance = distance;

                return output;
            }

            half4 frag(Varyings input) : SV_Target
            {
                float scrollTimeX = _ScrollX * _Time.y * 0.5;
                float scrollTimeY = _ScrollY * _Time.y * 0.5;
                
                half4 water;
                float foam;
                
                if (_UseTexture)
                {
                    water = _FoamColor * SAMPLE_TEXTURE2D(_FoamTex, sampler_FoamTex, input.uv + float2(scrollTimeX, scrollTimeY));
                    foam = SAMPLE_TEXTURE2D(_FoamTex, sampler_FoamTex, input.uv + float2(scrollTimeX, scrollTimeY)).a;
                }
                else
                {
                    water = _FoamColor;
                    foam = 0.5;
                }
                    return half4(1, 0, 0, 0.8);
            }
            ENDHLSL
        }
    }
}