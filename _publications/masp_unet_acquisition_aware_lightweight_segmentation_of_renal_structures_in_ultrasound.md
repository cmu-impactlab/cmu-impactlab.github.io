---
title: 'MASP-UNet: Acquisition-Aware Lightweight Segmentation of Renal Structures in Ultrasound'
authors:
- aaryal
- ma1
- efeoflus
conference: 'IEEE International Conference on Visual Communications and Image Processing (VCIP), 2026'
date: '2026-12-13'
year: '2026'
name: 'MASP-UNet'
pdf: '/pdfs/MASP-UNet__Acquisition-Aware_Lightweight_Segmentation_of_Renal_Structures_in_Ultrasound.pdf'
thumbnail: '/images/pubs/masp-unet-vcip-2026.png'
image: '/images/pubs/masp-unet-vcip-2026.png'
abstract: 'Renal substructure segmentation in ultrasound requires models that are both accurate and computationally efficient for point-of-care deployment. While high-capacity networks achieve strong segmentation performance, their computational demands limit practical use, whereas lightweight alternatives lack sufficient representational capacity. Existing methods also overlook acquisition metadata, despite ultrasound image characteristics varying systematically with imaging hardware. We present MASP-UNet, a lightweight acquisition-aware encoder–decoder that conditions its bottleneck representation on ultrasound acquisition metadata while integrating Spatial Pyramid Pooling (SPP), Multi-Context Aggregation (MCA), and attention-gated skip connections to capture multi-scale anatomical context within a compact architecture. On the Open Kidney Ultrasound Dataset, MASP-UNet achieves a mean Dice coefficient of 0.65 across cortex, medulla, and central echogenic complex segmentation, matching the best-performing baseline within 0.003 Dice while requiring only 5.7M parameters, 4.7 GFLOPs, and 53 ms CPU inference latency. These results indicate that acquisition-aware, multi-scale bottleneck conditioning improves the efficiency–accuracy trade-off for lightweight renal ultrasound segmentation, making the approach well-suited for resource-constrained clinical deployment.'
citation: 'Anurag Aryal, Mohammed Yusuf Ansari, and Eduardo Feo-Flushing. 2026 (to appear). MASP-UNet: Acquisition-Aware Lightweight Segmentation of Renal Structures in Ultrasound. IEEE International Conference on Visual Communications and Image Processing (VCIP).'
bibtex: |
  @INPROCEEDINGS{Aryal2026MASPUNet,
    author={Aryal, Anurag and Ansari, Mohammed Yusuf and Feo-Flushing, Eduardo},
    booktitle={2026 IEEE International Conference on Visual Communications and Image Processing (VCIP)},
    title={MASP-UNet: Acquisition-Aware Lightweight Segmentation of Renal Structures in Ultrasound},
    year={2026 (to appear)},
  }
blurb: 'A lightweight, acquisition-aware network that segments kidney structures in ultrasound in real time on a CPU.'
onhomepage: true
---
