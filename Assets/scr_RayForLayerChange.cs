using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scr_RayForLayerChange : MonoBehaviour {

	public LayerMask toRenderLayer;
	public Transform cam;

	int NumberOfObject;
	float myRayLenght = 15.0f;
	RaycastHit hitUp;
	RaycastHit hitDown;
	bool isplayerToutched; 
	Ray myRayUp;
	Ray myRayDown;
	void Start (){
	}
	void Update () {


		myRayUp = new Ray (transform.position, -transform.forward);
		myRayDown = new Ray (transform.position, transform.forward);
		Debug.DrawRay (myRayDown.origin,myRayDown.direction*myRayLenght,Color.magenta);
		Debug.DrawRay (myRayUp.origin,myRayUp.direction*myRayLenght,Color.magenta);
        if (Physics.Raycast (myRayUp, out hitUp, myRayLenght, toRenderLayer)){
			MultRayCastUp ();
		}
		if (Physics.Raycast (myRayDown, out hitUp, myRayLenght, toRenderLayer)){
			MultRayCastDown ();
		}

		/*if (OBup Physics.OverlapBox (myRayUp.origin)){
			MultRayCastUp ();
		}
		if (Physics.Raycast (myRayDown, out hitUp, myRayLenght, toRenderLayer)){
			MultRayCastDown ();
		}*/

		transform.rotation = cam.rotation;

	}

	void MultRayCastUp(){
			/*while (NumberOfObject < 2){
			if(Physics.Raycast (hit.transform.position,myRay.direction, out hit, myRayLenght, toRenderLayer)){
				Debug.DrawRay (hit.transform.position,myRay.direction*myRayLenght,Color.red);
				switch (NumberOfObject)
				{
				case 0:
					if (hit.transform.gameObject.layer == 9){
						hit.transform.gameObject.layer = 8;
					}
					if(hit.transform.gameObject.layer == 11){
						NumberOfObject = 1;
					}
					break;
				case 1:
					if (hit.transform.gameObject.layer == 9){
						hit.transform.gameObject.layer = 8;
					}
					break;
				}
			}else{
				NumberOfObject = 2;
			}
			print (hit.transform.gameObject.name);
		}
		NumberOfObject = 0;*/
		/*if (isplayerToutched){
				hitUp.transform.gameObject.layer = 8;
		}else{
				hitUp.transform.gameObject.layer = 9;
		}

		if (hitUp.transform.gameObject.layer == 11){
			print ("violer");
			isplayerToutched = true;
		}

		if(Physics.Raycast (hitUp.transform.position,myRayUp.direction, out hitUp, myRayLenght,toRenderLayer)){
			MultRayCast ();
		}*/
		hitUp.transform.gameObject.layer = 9;
		if (Physics.Raycast (hitUp.transform.position,myRayUp.direction, out hitUp, myRayLenght,toRenderLayer)){
			MultRayCastUp ();
		}
	}

	void MultRayCastDown(){
		hitUp.transform.gameObject.layer = 8;
		if (Physics.Raycast (hitUp.transform.position,myRayDown.direction, out hitUp, myRayLenght,toRenderLayer)){
			MultRayCastDown ();
			}
	}

}
