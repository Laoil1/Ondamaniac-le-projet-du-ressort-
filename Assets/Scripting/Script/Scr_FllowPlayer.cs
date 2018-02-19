using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Scr_FllowPlayer : MonoBehaviour {
	public Transform target;

	void Update () {
		FollowPlayer ();		
	}

	IEnumerator FollowPlayer (){
		yield return new WaitForSeconds (2);

		transform.position = target.position;

		yield break;
	}
}
