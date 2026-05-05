using UnityEngine;

namespace FlatKit
{
	[RequireComponent(typeof(Camera))]
	[ImageEffectAllowedInSceneView]
	[ExecuteInEditMode]
	public class OutlineImageEffect : MonoBehaviour
	{
		public Color edgeColor;

		[Range(0f, 5f)]
		public int thickness;

		[Space]
		public bool useDepth;

		public bool useNormals;

		[Header("Advanced settings")]
		[Space]
		public float minDepthThreshold;

		public float maxDepthThreshold;

		[Space]
		public float minNormalsThreshold;

		public float maxNormalsThreshold;

		[HideInInspector]
		public Material material;

		private Camera _camera;

		private static readonly string ShaderName;

		private static readonly int EdgeColorProperty;

		private static readonly int ThicknessProperty;

		private static readonly int DepthThresholdsProperty;

		private static readonly int NormalsThresholdsProperty;

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
	}
}
