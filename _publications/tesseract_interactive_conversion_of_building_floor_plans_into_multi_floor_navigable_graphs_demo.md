---
title: 'Tesseract: Interactive Conversion of Building Floor Plans into Multi-Floor Navigable Graphs [Demo]'
authors:
- yansari
- efeoflus
- kharras
conference: 'Proceedings of the 34th ACM International Conference on Advances in Geographic Information Systems (SIGSPATIAL), 2026'
date: '2026-11-03'
year: '2026'
name: 'Tesseract Demo'
pdf: '/pdfs/Tesseract__Interactive_Conversion_of_Building_Floor_Plans_into_Multi_Floor_Navigable_Graphs__Demo_.pdf'
thumbnail: '/images/pubs/tesseract-demo-sigspatial-2026.png'
image: '/images/pubs/tesseract-demo-sigspatial-2026.png'
abstract: 'Converting architectural floor plans into machine readable navigable graphs is a prerequisite for indoor routing, evacuation analysis, and spatial reasoning, yet it usually demands manual modeling or specialized capture hardware. We demonstrate Tesseract, an interactive web system that turns an annotated building floor plan image into a typed navigable graph in real time. A visitor uploads a floor plan or selects a curated example and watches the pipeline run live through text detection, label interpretation, flood fill segmentation, door detection and classification, connectivity construction, and pruning. The resulting graph is explored on an interactive canvas with node type filters, an adjustable floor plan overlay, and a pre versus post pruning view, and a live connectivity check flags any room or exit that routing cannot reach. The visitor can repair extraction defects by hand, with every edit undoable back to the originally extracted graph, and can export the result as an image or as JSON. The centerpiece is live indoor navigation, where the visitor picks a start node and a destination node and the system animates the shortest route found by in browser A* search, climbing through stair and elevator transitions when the route crosses floors. Tesseract runs in the browser against a deployed backend and is publicly available, so attendees can test it on their own floor plans.'
citation: 'Yaqoob Ansari, Eduardo Feo Flushing, and Khaled A. Harras. 2026 (to appear). Tesseract: Interactive Conversion of Building Floor Plans into Multi-Floor Navigable Graphs [Demo]. In Proceedings of the 34th ACM SIGSPATIAL International Conference on Advances in Geographic Information Systems (SIGSPATIAL ''26). ACM, New York, NY, USA.'
bibtex: |
  @INPROCEEDINGS{Ansari2026TesseractDemo,
    author={Ansari, Yaqoob and Feo Flushing, Eduardo and Harras, Khaled A.},
    booktitle={Proceedings of the 34th ACM SIGSPATIAL International Conference on Advances in Geographic Information Systems (SIGSPATIAL '26)},
    title={Tesseract: Interactive Conversion of Building Floor Plans into Multi-Floor Navigable Graphs [Demo]},
    year={2026 (to appear)},
    publisher={ACM},
  }
blurb: 'A live web demo that turns building floor plans into multi-floor navigable graphs you can inspect, repair, and route over.'
onhomepage: true
---
