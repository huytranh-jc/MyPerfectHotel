using UnityEngine;

namespace FlatKit
{
	[ExecuteInEditMode]
	[ImageEffectAllowedInSceneView]
	[RequireComponent(typeof(Camera))]
	public class FogImageEffect : MonoBehaviour
	{
		public bool useDistance;

		public Gradient distanceGradient;

		public float near;

		public float far;

		[Range(0f, 1f)]
		public float distanceFogIntensity;

		public bool useDistanceFogOnSky;

		[Space]
		public bool useHeight;

		public Gradient heightGradient;

		public float low;

		public float high;

		[Range(0f, 1f)]
		public float heightFogIntensity;

		public bool useHeightFogOnSky;

		[Space]
		[Range(0f, 1f)]
		public float distanceHeightBlend;

		[HideInInspector]
		public Material material;

		private Camera _camera;

		private Texture2D _lutDepth;

		private Texture2D _lutHeight;

		private static readonly string ShaderName;

		private static readonly int DistanceLut;

		private static readonly int Near;

		private static readonly int Far;

		private static readonly int UseDistanceFog;

		private static readonly int UseDistanceFogOnSky;

		private static readonly int DistanceFogIntensity;

		private static readonly int HeightLut;

		private static readonly int LowWorldY;

		private static readonly int HighWorldY;

		private static readonly int UseHeightFog;

		private static readonly int UseHeightFogOnSky;

		private static readonly int HeightFogIntensity;

		private static readonly int DistanceHeightBlend;

		private void Awake()
		{
		}

		private void Start()
		{
		}

		private void OnValidate()
		{
		}

		[ImageEffectOpaque]
		private void OnRenderImage(RenderTexture source, RenderTexture destination)
		{
		}

		private void UpdateShader()
		{
		}

		private void UpdateDistanceLut()
		{
		}

		private void UpdateHeightLut()
		{
		}
	}
}
