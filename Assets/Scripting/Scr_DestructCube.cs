using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Scr_DestructCube : MonoBehaviour {


	void OnCollisionEnter (Collision other){
		print (other.gameObject.tag); 
		if (other.gameObject.tag == "Player"){  
			SceneManager.LoadScene (SceneManager.GetActiveScene ().name);
		} 
	}

}
