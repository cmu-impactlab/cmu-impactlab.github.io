---
title: 'LEAN: A Lightweight and Scalable Attention Network for ECG Age Estimation as a Marker of Cardiovascular Health'
authors:
- ma1
- MD Rabiul Islam
- yansari
- Mohammed Ishaq
- Wajid Yousuf
- Vaisali Chandrasekar
- Sarada Prasad Dakua
- Marwa Qaraqe
- efeoflus
conference: 'International Conference on Digital Image Computing: Techniques and Applications (DICTA), 2026'
date: '2026-12-02'
year: '2026'
name: 'LEAN'
pdf: '/pdfs/LEAN__A_Lightweight_and_Scalable_Attention_Network_for_ECG_Age_Estimation_as_a_Marker_of_Cardiovascular_Health.pdf'
thumbnail: '/images/pubs/lean-dicta-2026.png'
image: '/images/pubs/lean-dicta-2026.png'
abstract: 'An electrocardiogram (ECG) is a widely used noninvasive test for diagnosing cardiac disease. Recent work has established that the gap between a neural-network-derived ECG age and the chronological age is a useful measure of cardiovascular well-being. However, most ECG age estimators reuse networks built for disease diagnosis, and these tend to be computationally heavy and difficult to scale. We propose LEAN, a lightweight and scalable hybrid of convolution and self-attention for efficient ECG age estimation. LEAN extracts features through a shallow backbone of ECGNext blocks and then applies a self-attention block that supplies the long-range receptive field the shallow backbone cannot reach on its own. A multi-shot inference scheme further refines each prediction by averaging over several crops of the recording. Furthermore, a healthy-reference analysis shows that LEAN-derived ECG age gaps provide a disease-associated aging marker, with pathological recordings appearing approximately four years older than healthy recordings across multiple cardiac conditions. LEAN is instantiated as a family of variants, so a practitioner can match the model to the available computational budget. Its smallest variant, LEAN-Lite, surpasses the strongest existing ECG age estimation network by 4.3% in MSE while using 42× fewer parameters, and the family as a whole attains accurate age estimation at a small fraction of the memory and computation of prior models, making it deployable on resource-constrained point-of-care devices for cardiovascular screening.'
citation: 'Mohammed Yusuf Ansari, MD Rabiul Islam, Mohammed Yaqoob, Mohammed Ishaq, Wajid Yousuf, Vaisali Chandrasekar, Sarada Prasad Dakua, Marwa Qaraqe, and Eduardo Feo Flushing. 2026 (to appear). LEAN: A Lightweight and Scalable Attention Network for ECG Age Estimation as a Marker of Cardiovascular Health. International Conference on Digital Image Computing: Techniques and Applications (DICTA).'
bibtex: |
  @INPROCEEDINGS{Ansari2026LEAN,
    author={Ansari, Mohammed Yusuf and Islam, MD Rabiul and Yaqoob, Mohammed and Ishaq, Mohammed and Yousuf, Wajid and Chandrasekar, Vaisali and Dakua, Sarada Prasad and Qaraqe, Marwa and Feo Flushing, Eduardo},
    booktitle={2026 International Conference on Digital Image Computing: Techniques and Applications (DICTA)},
    title={LEAN: A Lightweight and Scalable Attention Network for ECG Age Estimation as a Marker of Cardiovascular Health},
    year={2026 (to appear)},
  }
blurb: 'A compact attention network that estimates "heart age" from ECGs as a cardiovascular health marker, beating the best prior model with 42× fewer parameters.'
onhomepage: true
---
