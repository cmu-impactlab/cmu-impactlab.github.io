---
title: 'Directional Navigability Estimation from Ultra-Low-Resolution Multi-View Thermal Sensing'
authors:
- Faiz Moazam
- jhussien
- ataweel
- gramalho
- yansari
- efeoflus
conference: 'IEEE International Conference on Visual Communications and Image Processing (VCIP), 2026'
date: '2026-12-13'
year: '2026'
name: 'Thermal Navigability'
pdf: '/pdfs/Directional_Navigability_Estimation_from_Ultra-Low-Resolution_Multi-View_Thermal_Sensing.pdf'
thumbnail: '/images/pubs/thermal-navigability-vcip-2026.png'
image: '/images/pubs/thermal-navigability-vcip-2026.png'
abstract: 'Wearable navigation systems typically depend on high-resolution cameras, depth sensors, and large annotated datasets, a dependence that limits their deployability in privacy-sensitive indoor environments and raises development costs. This paper investigates whether directional navigability can be estimated solely from ultra-low-resolution thermal imagery captured by a wearable multi-camera platform. We propose a learning framework in which high-resolution RGB imagery, available only during data collection, automatically generates navigability labels through a pretrained object detector, eliminating manual annotation. Unlike conventional cross-modal approaches, the framework uses only coarse geometric alignment for automatic labeling and requires no geometric calibration at inference. Experiments with three 32 × 24 thermal cameras show that directional navigability is reliably inferred from thermal input alone and that feature-level fusion outperforms per-camera prediction as well as pixel- and decision-level fusion. A lightweight camera-identity classifier restores near-oracle accuracy when the input ordering changes, and every fusion architecture runs in under 3 ms per frame on CPU. These results suggest that ultra-low-resolution thermal sensing can serve as a scalable and privacy-preserving foundation for wearable indoor navigation.'
citation: 'Faiz Moazam, Jana Hussien, Abdulrahman Al-Taweel, Gustavo Ramalho, Yaqoob Ansari, and Eduardo Feo-Flushing. 2026 (to appear). Directional Navigability Estimation from Ultra-Low-Resolution Multi-View Thermal Sensing. IEEE International Conference on Visual Communications and Image Processing (VCIP).'
bibtex: |
  @INPROCEEDINGS{Moazam2026ThermalNavigability,
    author={Moazam, Faiz and Hussien, Jana and Al-Taweel, Abdulrahman and Ramalho, Gustavo and Ansari, Yaqoob and Feo-Flushing, Eduardo},
    booktitle={2026 IEEE International Conference on Visual Communications and Image Processing (VCIP)},
    title={Directional Navigability Estimation from Ultra-Low-Resolution Multi-View Thermal Sensing},
    year={2026 (to appear)},
  }
blurb: 'Estimating which directions are walkable from three tiny 32×24 thermal cameras, trained without manual labels.'
onhomepage: true
---
