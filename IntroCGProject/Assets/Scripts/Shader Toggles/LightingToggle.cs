using UnityEngine;

public class ToggleGameObjects : MonoBehaviour
{
    [SerializeField] GameObject[] _lightingToggle;
    [SerializeField] KeyCode _toggleKey = KeyCode.L;
    [SerializeField] bool _setActive = true;

    private void Start()
    {
        SetObjectsActive(_setActive);
    }

    private void Update()
    {
        if (Input.GetKeyDown(_toggleKey))
            ToggleObjects();
    }

    public void ToggleObjects()
    {
        foreach (GameObject obj in _lightingToggle)
        {
            if (obj != null)
                obj.SetActive(!obj.activeSelf);
        }
    }

    public void SetObjectsActive(bool active)
    {
        foreach (GameObject obj in _lightingToggle)
        {
            if (obj != null)
                obj.SetActive(active);
        }
    }
}
