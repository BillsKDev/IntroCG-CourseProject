using UnityEngine;
using UnityEngine.UI;

public class ColorGradingToggle : MonoBehaviour
{
    [SerializeField] Material coolLUT;
    [SerializeField] Material warmLUT;
    [SerializeField] Material deadLUT;
    [SerializeField] Material normalLUT;
    [SerializeField] Shader shader;
    [SerializeField] Image renderImage;

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha5))
        {
            Debug.Log("Switched to Warm");
            renderImage.color = new Color(1, 1, 1, 1);
            renderImage.material = warmLUT;
        }

        if (Input.GetKeyDown(KeyCode.Alpha6))
        {
            Debug.Log("Switched to Dead");
            renderImage.color = new Color(1, 1, 1, 1);
            renderImage.material = deadLUT;
        }

        if (Input.GetKeyDown(KeyCode.Alpha7))
        {
            Debug.Log("Switched to Cool");
            renderImage.color = new Color(1, 1, 1, 1);
            renderImage.material = coolLUT;
        }

        if (Input.GetKeyDown(KeyCode.Alpha8))
        {
            Debug.Log("Switched to Normal");
            renderImage.color = new Color(1, 1, 1, 0);
            renderImage.material = normalLUT;
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination);
    }
}