using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class scr_level_manager : MonoBehaviour {

	public string NameOfScene;


	void OnTriggerEnter (Collider other){
		print (NameOfScene); 
		SceneManager.LoadScene (NameOfScene);

	}
}
