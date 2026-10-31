---
title: 'GraphWalker: Deployable Inertial-Based Indoor Localization via Trajectory to Graph Alignment'
authors:
- mai
- yansari
- kharras
- efeoflus
conference: 'Proceedings of the 34th ACM International Conference on Advances in Geographic Information Systems (SIGSPATIAL), 2026'
date: '2026-11-03'
year: '2026'
name: 'GraphWalker SIGSPATIAL'
pdf: '/pdfs/GraphWalker__Deployable_Inertial_Based_Indoor_Localization_via_Trajectory_to_Graph_Alignment.pdf'
thumbnail: '/images/pubs/graphwalker-sigspatial-2026.png'
image: '/images/pubs/graphwalker-sigspatial-2026.png'
abstract: 'Inertial indoor localization is attractive because it requires no infrastructure and reveals no identifying signals, yet unbounded drift and the absence of a global coordinate frame prevent it from serving as a standalone solution. Existing map-constrained approaches mitigate drift using floor plans, but typically rely on dense geometric maps, calibrated probabilistic models, or offline global inference. We present GraphWalker, a real-time indoor localization system that aligns IMU-derived trajectories with coarse semantic floor plan graphs through online trajectory-to-graph alignment. GraphWalker maintains multiple candidate path hypotheses through bounded beam search and independently corrects drift for each hypothesis, requiring only a coarse semantic graph, a known starting pose, and commodity inertial sensing. On 152 real-world trajectories totaling 9 km of walking across three floor plans, GraphWalker improves localization accuracy by up to 50% over map-free and map-constrained baselines and reduces path errors by 42%, while maintaining real-time operation.'
citation: 'Maimoonah Al-Mashhadani, Yaqoob Ansari, Khaled A. Harras, and Eduardo Feo-Flushing. 2026 (to appear). GraphWalker: Deployable Inertial-Based Indoor Localization via Trajectory to Graph Alignment. In The 34th ACM International Conference on Advances in Geographic Information Systems (SIGSPATIAL ''26). ACM, New York, NY, USA. https://doi.org/10.1145/3841645.3843004'
bibtex: |
  @INPROCEEDINGS{AlMashhadani2026GraphWalker,
    author={Al-Mashhadani, Maimoonah and Ansari, Yaqoob and Harras, Khaled A. and Feo-Flushing, Eduardo},
    booktitle={Proceedings of the 34th ACM International Conference on Advances in Geographic Information Systems (SIGSPATIAL '26)},
    title={GraphWalker: Deployable Inertial-Based Indoor Localization via Trajectory to Graph Alignment},
    year={2026 (to appear)},
    publisher={ACM},
    doi={10.1145/3841645.3843004},
  }
blurb: 'Real-time indoor localization from a phone''s inertial sensors, kept on track by matching the walked path to a simple floor plan graph.'
onhomepage: true
---
