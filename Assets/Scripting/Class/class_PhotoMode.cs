using System.Collections;
using System.Collections.Generic;
using UnityEngine;


[System.Serializable]
public class class_PhotoMode {


	[HideInInspector]
	public Transform transform;

	public float mouseSpeed = 5;
	public Transform headTransform;

	public void UpdateOrientation()
	{
		//on récupère les inputs de la souris
		float lookX = Input.GetAxisRaw("Mouse X");
		float lookY = Input.GetAxisRaw("Mouse Y");

		//on réoriente le joueur latéralement
		Vector3 rotationPlayer = new Vector3(0, lookX * mouseSpeed, 0);
		transform.Rotate(rotationPlayer);

		//on réoriente la caméra verticalement
		Vector3 rotationHead = new Vector3(-lookY * mouseSpeed, 0, 0);
		Vector3 currentRotation = headTransform.eulerAngles;

		//on limite l'orientation de la caméra entre 90 et -90°
		if (currentRotation.x - lookY * mouseSpeed < 90 || currentRotation.x - lookY * mouseSpeed > 270)
		{
			headTransform.Rotate(rotationHead);
		}

	}



}
