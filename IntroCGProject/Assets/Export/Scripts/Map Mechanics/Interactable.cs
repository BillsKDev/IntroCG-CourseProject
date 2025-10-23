using UnityEngine;
using UnityEngine.Events;

public class Interactable : MonoBehaviour
{
    [SerializeField] UnityEvent onUp;
    [SerializeField] UnityEvent onDown;
    Animator animator;
    bool leverDown;
    bool playerInRange;

    void Start()
    {
        animator = GetComponent<Animator>();
        leverDown = false;
        playerInRange = false;
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            playerInRange = true;
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            playerInRange = false;
        }
    }

    public void TryInteract()
    {
        if (playerInRange)
            ToggleLever();
    }

    void ToggleLever()
    {
        if (leverDown)
        {
            Debug.Log("lever up " + this.gameObject.name);
            onUp.Invoke();
            animator.SetTrigger("Up");
        }
        else
        {
            Debug.Log("lever down " + this.gameObject.name);
            onDown.Invoke();
            animator.SetTrigger("Down");
        }
        leverDown = !leverDown;
    }
}