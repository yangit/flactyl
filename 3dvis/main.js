import * as THREE from 'three';
console.log(THREE)
import { STLLoader } from 'three/addons/loaders/STLLoader.js';

// Scene
var scene = new THREE.Scene();

// Camera
var camera = new THREE.PerspectiveCamera(50, window.innerWidth / window.innerHeight, 0.1, 1000);
camera.position.x = 0;
camera.position.y = 400;
camera.position.z = 0;
camera.lookAt(scene.position);
console.log(scene.position);

// Renderer
var renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
document.body.appendChild(renderer.domElement);

// STL Loader
var loader = new STLLoader();

// Load your STL file
loader.load('./left.stl', function (geometry) {
    var material = new THREE.MeshNormalMaterial();
    var mesh = new THREE.Mesh(geometry, material);
    scene.add(mesh);
    // mesh.rotation.y = (Math.PI/180) *90;
    // mesh.rotation.z = 270;
    // mesh.rotation.y = 0;
    // Render Loop
    var animate = function () {

        requestAnimationFrame(animate);

        // Rotate model
        // mesh.rotation.x += 0.01;  // For rotation around X-axis
        // mesh.rotation.y += 0.01;  // For rotation around Y-axis
        // mesh.rotation.z += 0.01; // For rotation around Z-axis (optional)

        // Render
        renderer.render(scene, camera);

    };
    animate();
});