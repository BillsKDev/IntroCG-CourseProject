using UnityEngine;

public class ColorGradingToggle : MonoBehaviour
{
    [SerializeField] Material coolLUT;
    [SerializeField] Material warmLUT;
    [SerializeField] Material deadLUT;
    [SerializeField] Material normalLUT;
    [SerializeField] Shader shader;

    Material currentLUT;

    void Start() => currentLUT = normalLUT;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha5))
        {
            Debug.Log("Switched to Warm");
            currentLUT = warmLUT;
            
        }

        if (Input.GetKeyDown(KeyCode.Alpha6))
        {
            Debug.Log("Switched to Warm");
            currentLUT = deadLUT;
        }

        if (Input.GetKeyDown(KeyCode.Alpha7))
        {
            Debug.Log("Switched to Dead");
            currentLUT = coolLUT;
        }

        if (Input.GetKeyDown(KeyCode.Alpha8))
        {
            Debug.Log("Switched to Normal");
            currentLUT = normalLUT;
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (currentLUT != null)
        {
            Graphics.Blit(source, destination, currentLUT);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}