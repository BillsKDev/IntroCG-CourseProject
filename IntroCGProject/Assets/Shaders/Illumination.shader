Shader "Custom/IsolatedLighting"
{
    Properties
    {
        _Texture ("Texture", 2D) = "white" {}  
        _SpecColor ("Specular Color", Color) = (1,1,1,1)
        _Shininess ("Shininess", Range(0.1, 100)) = 16
        _LightingMode ("Lighting Mode", Float) = 1
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
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 normalOS   : NORMAL;
                float2 uv         : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float3 normalWS    : TEXCOORD0;
                float3 viewDirWS   : TEXCOORD1;
                float2 uv          : TEXCOORD2;
            };

            TEXTURE2D(_Texture);
            SAMPLER(sampler_Texture);

            CBUFFER_START(UnityPerMaterial)
                float4 _SpecColor;
                float _Shininess;
                float _LightingMode;
                float4 _Texture_ST; 
            CBUFFER_END

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                float3 worldPos = TransformObjectToWorld(IN.positionOS.xyz);
                OUT.positionHCS = TransformWorldToHClip(worldPos);
                OUT.normalWS = TransformObjectToWorldNormal(IN.normalOS);
                OUT.viewDirWS = normalize(GetCameraPositionWS() - worldPos);
                OUT.uv = TRANSFORM_TEX(IN.uv, _Texture); 
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                half4 texColor = SAMPLE_TEXTURE2D(_Texture, sampler_Texture, IN.uv);
                
                float3 N = SafeNormalize(IN.normalWS);
                float3 V = SafeNormalize(IN.viewDirWS);
                Light mainLight = GetMainLight();
                float3 L = normalize(mainLight.direction);
                
                half3 ambient = SampleSH(N);
                half3 diffuse = mainLight.color.rgb * saturate(dot(N, L));
                float3 reflectDir = reflect(-L, N);
                float specFactor = pow(saturate(dot(reflectDir, V)), _Shininess);
                half3 specular = _SpecColor.rgb * specFactor * mainLight.color.rgb;
                
                if (_LightingMode == 0) return texColor; // no lighting
                else if (_LightingMode == 1) return half4(texColor * diffuse, 1.0); // diffuse
                else if (_LightingMode == 2) return half4(texColor.rgb * ambient, 1.0); // ambient
                else if (_LightingMode == 3) return half4(specular, 1.0); // specular
                else if (_LightingMode == 4) // ambient/specular
                {
                    half3 finalColor = (texColor.rgb * ambient) + specular;
                    return half4(finalColor, 1.0);
                }
                
                return texColor;
            }
            ENDHLSL
        }
    }
}